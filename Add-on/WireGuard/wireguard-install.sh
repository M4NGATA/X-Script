#!/bin/bash

# Установщик безопасного сервера WireGuard
# https://github.com/angristan/wireguard-install

RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

function isRoot() {
	if [ "${EUID}" -ne 0 ]; then
		echo "Необходимо запустить этот скрипт от имени root"
		exit 1
	fi
}

function checkVirt() {
	if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ не поддерживается"
		exit 1
	fi

	if [ "$(systemd-detect-virt)" == "lxc" ]; then
		echo "LXC не поддерживается (пока)."
		echo "WireGuard теоретически может работать в контейнере LXC,"
		echo "но модуль ядра должен быть установлен на хосте,"
		echo "контейнер должен быть запущен с некоторыми специфическими параметрами"
		echo "и в контейнере должны быть установлены только необходимые инструменты."
		exit 1
	fi
}

function checkOS() {
	source /etc/os-release
	OS="${ID}"
	if [[ ${OS} == "debian" || ${OS} == "raspbian" ]]; then
		if [[ ${VERSION_ID} -lt 10 ]]; then
			echo "Ваша версия Debian (${VERSION_ID}) не поддерживается. Используйте Debian 10 Buster или более позднюю версию."
			exit 1
		fi
		OS=debian # переопределить, если raspbian
	elif [[ ${OS} == "ubuntu" ]]; then
		RELEASE_YEAR=$(echo "${VERSION_ID}" | cut -d'.' -f1)
		if [[ ${RELEASE_YEAR} -lt 18 ]]; then
			echo "Ваша версия Ubuntu (${VERSION_ID}) не поддерживается. Используйте Ubuntu 18.04 или более позднюю версию."
			exit 1
		fi
	elif [[ ${OS} == "fedora" ]]; then
		if [[ ${VERSION_ID} -lt 32 ]]; then
			echo "Ваша версия Fedora (${VERSION_ID}) не поддерживается. Используйте Fedora 32 или более позднюю версию."
			exit 1
		fi
	elif [[ ${OS} == 'centos' ]] || [[ ${OS} == 'almalinux' ]] || [[ ${OS} == 'rocky' ]]; then
		if [[ ${VERSION_ID} == 7* ]]; then
			echo "Ваша версия CentOS (${VERSION_ID}) не поддерживается. Используйте CentOS 8 или более позднюю версию."
			exit 1
		fi
	elif [[ -e /etc/oracle-release ]]; then
		source /etc/os-release
		OS=oracle
	elif [[ -e /etc/arch-release ]]; then
		OS=arch
	else
		echo "Похоже, вы запускаете этот установщик не на Debian, Ubuntu, Fedora, CentOS, AlmaLinux, Oracle или Arch Linux."
		exit 1
	fi
}

function getHomeDirForClient() {
	local CLIENT_NAME=$1

	if [ -z "${CLIENT_NAME}" ]; then
		echo "Ошибка: функция getHomeDirForClient() требует имя клиента в качестве аргумента"
		exit 1
	fi

	# Домашняя директория пользователя, где будет записана конфигурация клиента
	if [ -e "/home/${CLIENT_NAME}" ]; then
		# если $1 - это имя пользователя
		HOME_DIR="/home/${CLIENT_NAME}"
	elif [ "${SUDO_USER}" ]; then
		# если нет, используйте SUDO_USER
		if [ "${SUDO_USER}" == "root" ]; then
			# Если запущено sudo как root
			HOME_DIR="/root"
		else
			HOME_DIR="/home/${SUDO_USER}"
		fi
	else
		# если нет SUDO_USER, используйте /root
		HOME_DIR="/root"
	fi

	echo "$HOME_DIR"
}

function initialCheck() {
	isRoot
	checkVirt
	checkOS
}

function installQuestions() {
	echo "Добро пожаловать в установщик WireGuard!"
	echo "Репозиторий git доступен по адресу: https://github.com/angristan/wireguard-install"
	echo ""
	echo "Мне нужно задать вам несколько вопросов перед началом установки."
	echo "Вы можете оставить параметры по умолчанию, просто нажав Enter, если они вас устраивают."
	echo ""

	# Определите общедоступный IPv4- или IPv6-адрес и предварительно заполните его для пользователя
	SERVER_PUB_IP=$(ip -4 addr | sed -ne 's|^.* inet \([^/]*\)/.* scope global.*$|\1|p' | awk '{print $1}' | head -1)
	if [[ -z ${SERVER_PUB_IP} ]]; then
		# Определите общедоступный IPv6-адрес
		SERVER_PUB_IP=$(ip -6 addr | sed -ne 's|^.* inet6 \([^/]*\)/.* scope global.*$|\1|p' | head -1)
	fi
	read -rp "IPv4 или IPv6 общедоступный адрес: " -e -i "${SERVER_PUB_IP}" SERVER_PUB_IP

	# Определите общедоступный интерфейс и предварительно заполните его для пользователя
	SERVER_NIC="$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)' | head -1)"
	until [[ ${SERVER_PUB_NIC} =~ ^[a-zA-Z0-9_]+$ ]]; do
		read -rp "Общедоступный интерфейс: " -e -i "${SERVER_NIC}" SERVER_PUB_NIC
	done

	until [[ ${SERVER_WG_NIC} =~ ^[a-zA-Z0-9_]+$ && ${#SERVER_WG_NIC} -lt 16 ]]; do
		read -rp "Имя интерфейса WireGuard: " -e -i wg0 SERVER_WG_NIC
	done

	until [[ ${SERVER_WG_IPV4} =~ ^([0-9]{1,3}\.){3} ]]; do
		read -rp "IPv4-адрес для WireGuard: " -e -i 10.66.66.1 SERVER_WG_IPV4
	done

	until [[ ${SERVER_WG_IPV6} =~ ^([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4} ]]; do
		read -rp "IPv6-адрес для WireGuard (необязательно): " -e -i "" SERVER_WG_IPV6
	done

	# Клиенты DNS
	until [[ ${CLIENT_DNS} =~ ^[a-zA-Z0-9.,]+$ ]]; do
		read -rp "DNS для клиентов: " -e -i 1.1.1.1 CLIENT_DNS
	done

	# Переделываем рекомендации для IPv6
	if [[ ! ${SERVER_WG_IPV6} ]]; then
		CLIENT_WG_IPV6="fd42:42:42::1/64"
	else
		CLIENT_WG_IPV6="${SERVER_WG_IPV6}"
	fi

	# Максимальное количество подключений клиента
	until [[ ${CLIENT_CONNECTIONS} =~ ^[0-9]+$ && ${CLIENT_CONNECTIONS} -gt 0 ]]; do
		read -rp "Максимальное количество подключений клиента: " -e -i 5 CLIENT_CONNECTIONS
	done

	echo ""
	echo "Доступ к SSH на сервере будет ограничен только по WireGuard (или с помощью ключей)"
	echo "И отключен парольный доступ"
	read -n1 -r -p "Нажмите любую клавишу, чтобы продолжить..."
	echo ""
}

function installWireGuard() {
	# Установка WireGuard
	echo -e "Установка ${GREEN}WireGuard${NC}..."
	if [[ ${OS} == 'ubuntu' ]]; then
		apt-get install -y wireguard
	elif [[ ${OS} == 'debian' ]]; then
		echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable.list
		printf 'Package: *\nPin: release a=unstable\nPin-Priority: 150\n' > /etc/apt/preferences.d/limit-unstable
		apt-get update
		apt-get install -y wireguard
		rm /etc/apt/sources.list.d/unstable.list
		rm /etc/apt/preferences.d/limit-unstable
	elif [[ ${OS} == 'fedora' ]]; then
		dnf copr enable jdoss/wireguard
		dnf install -y wireguard-dkms wireguard-tools
	elif [[ ${OS} == 'centos' ]] || [[ ${OS} == 'almalinux' ]] || [[ ${OS} == 'rocky' ]]; then
		dnf install -y epel-release elrepo
		dnf install -y kmod-wireguard wireguard-tools
	fi

	# Проверка, установлен ли WireGuard
	if ! modprobe -nq wireguard; then
		echo -e "${RED}Ошибка: Установка WireGuard не удалась.${NC}"
		echo "Вероятно, ваше ядро не поддерживает WireGuard."
		echo "Пожалуйста, убедитесь, что вы используете ядро с поддержкой WireGuard."
		exit 1
	fi
}

function setSysctl() {
	# Включение IP-пересылки и IP-прямой отправки
	echo -e "Настройка ${GREEN}sysctl${NC}..."

	if ! grep -q "net.ipv4.ip_forward" /etc/sysctl.conf; then
		echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
	fi

	if ! grep -q "net.ipv4.conf.all.send_redirects" /etc/sysctl.conf; then
		echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
	fi

	if ! grep -q "net.ipv4.conf.default.send_redirects" /etc/sysctl.conf; then
		echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf
	fi

	if [[ ${SERVER_WG_IPV6} ]]; then
		if ! grep -q "net.ipv6.conf.all.forwarding" /etc/sysctl.conf; then
			echo "net.ipv6.conf.all.forwarding = 1" >> /etc/sysctl.conf
		fi

		if ! grep -q "net.ipv6.conf.default.forwarding" /etc/sysctl.conf; then
			echo "net.ipv6.conf.default.forwarding = 1" >> /etc/sysctl.conf
		fi
	fi

	sysctl -p
}

function installUFW() {
	# Установка и настройка UFW
	echo -e "Установка и настройка ${GREEN}UFW${NC} (брандмауэр)..."

	apt-get install -y ufw

	# Настройка UFW для SSH и WireGuard
	ufw allow OpenSSH
	ufw allow 51820/udp
	echo "y" | ufw enable
}

function generateKeys() {
	# Генерация ключей сервера
	echo -e "Генерация ключей WireGuard..."

	mkdir -p /etc/wireguard/
	cd /etc/wireguard/ || exit

	umask 077
	wg genkey | tee privatekey | wg pubkey > publickey
	SERVER_PRIVATE_KEY=$(cat privatekey)
	SERVER_PUBLIC_KEY=$(cat publickey)
}

function generateServerConfig() {
	# Создание конфигурационного файла для сервера
	echo -e "Создание конфигурационного файла для сервера..."

	echo "[Interface]
Address = ${SERVER_WG_IPV4}
${SERVER_WG_IPV6:+Address = ${SERVER_WG_IPV6}}
ListenPort = 51820
PrivateKey = ${SERVER_PRIVATE_KEY}
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE; ip6tables -D FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -D POSTROUTING -o ${SERVER_PUB_NIC} -j MASQUERADE
SaveConfig = true" > wg0.conf
}

function addClient() {
	# Добавление нового клиента
	echo -e "Добавление нового клиента..."

	CLIENT_NAME=$(tr -dc 'a-z0-9' < /dev/urandom | head -c 12)

	mkdir -p /etc/wireguard/clients
	cd /etc/wireguard/clients || exit

	umask 077
	wg genkey | tee "${CLIENT_NAME}_privatekey" | wg pubkey > "${CLIENT_NAME}_publickey"

	CLIENT_PRIVATE_KEY=$(cat "${CLIENT_NAME}_privatekey")
	CLIENT_PUBLIC_KEY=$(cat "${CLIENT_NAME}_publickey")

	echo -e "[Peer]
PublicKey = ${CLIENT_PUBLIC_KEY}
AllowedIPs = ${CLIENT_WG_IPV4}
${CLIENT_WG_IPV6:+AllowedIPs = ${CLIENT_WG_IPV6}}" > "${CLIENT_NAME}_peer.conf"

	# Добавление конфигурации клиента в файл
	echo -e "\nКонфигурация для нового клиента (${CLIENT_NAME}_peer.conf):"
	cat "${CLIENT_NAME}_peer.conf"
	echo ""
}

function showClientConfig() {
	# Показать конфигурацию клиента
	echo -e "Конфигурация клиента ${GREEN}${CLIENT_NAME}${NC} (${CLIENT_NAME}_peer.conf):"
	cat "/etc/wireguard/clients/${CLIENT_NAME}_peer.conf"
	echo ""
}

function createQRCode() {
	# Создание QR-кода для конфигурации клиента
	qrencode -t ansiutf8 < "/etc/wireguard/clients/${CLIENT_NAME}_peer.conf"
}

function updateFirewallRules() {
	# Обновление правил брандмауэра
	echo -e "Обновление правил брандмауэра..."

	# Удаление старых правил
	ufw delete 1
	ufw delete 1

	# Добавление новых правил
	ufw allow OpenSSH
	ufw allow 51820/udp
	ufw --force enable
}

function startWireGuard() {
	# Запуск службы WireGuard
	echo -e "Запуск службы ${GREEN}WireGuard${NC}..."

	systemctl start wg-quick@wg0
	systemctl enable wg-quick@wg0
}

function main() {
	checkRoot
	checkOS
	checkWireGuard
	installWireGuard
	setVariables
	setSysctl
	installUFW
	generateKeys
	generateServerConfig
	addClient
	showClientConfig
	createQRCode
	updateFirewallRules
	startWireGuard

	echo -e "${GREEN}WireGuard установлен и настроен успешно!${NC}"
}

main

