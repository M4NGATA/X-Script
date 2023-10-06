#!/bin/bash

# Установщик безопасного сервера WireGuard
# https://github.com/angristan/wireguard-install

КРАСНЫЙ='\033[0;31m'
ОРАНЖЕВЫЙ='\033[0;33m'
ЗЕЛЕНЫЙ='\033[0;32m'
СБРОС='\033[0m'

function isRoot() {
	if [ "${EUID}" -ne 0 ]; then
		echo "Вы должны запустить этот скрипт с правами root"
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
		echo "контейнер должен быть запущен с определенными параметрами"
		echo "и в контейнере должны быть установлены только инструменты."
		exit 1
	fi
}

function checkOS() {
	source /etc/os-release
	OS="${ID}"
	if [[ ${OS} == "debian" || ${OS} == "raspbian" ]]; then
		if [[ ${VERSION_ID} -lt 10 ]]; then
			echo "Ваша версия Debian (${VERSION_ID}) не поддерживается. Пожалуйста, используйте Debian 10 Buster или более позднюю версию"
			exit 1
		fi
		OS=debian # переопределяем, если это raspbian
	elif [[ ${OS} == "ubuntu" ]]; then
		RELEASE_YEAR=$(echo "${VERSION_ID}" | cut -d'.' -f1)
		if [[ ${RELEASE_YEAR} -lt 18 ]]; then
			echo "Ваша версия Ubuntu (${VERSION_ID}) не поддерживается. Пожалуйста, используйте Ubuntu 18.04 или более позднюю версию"
			exit 1
		fi
	elif [[ ${OS} == "fedora" ]]; then
		if [[ ${VERSION_ID} -lt 32 ]]; then
			echo "Ваша версия Fedora (${VERSION_ID}) не поддерживается. Пожалуйста, используйте Fedora 32 или более позднюю версию"
			exit 1
		fi
	elif [[ ${OS} == 'centos' ]] || [[ ${OS} == 'almalinux' ]] || [[ ${OS} == 'rocky' ]]; then
		if [[ ${VERSION_ID} == 7* ]]; then
			echo "Ваша версия CentOS (${VERSION_ID}) не поддерживается. Пожалуйста, используйте CentOS 8 или более позднюю версию"
			exit 1
		fi
	elif [[ -e /etc/oracle-release ]]; then
		source /etc/os-release
		OS=oracle
	elif [[ -e /etc/arch-release ]]; then
		OS=arch
	else
		echo "Похоже, вы запускаете этот установщик не на системе Debian, Ubuntu, Fedora, CentOS, AlmaLinux, Oracle или Arch Linux"
		exit 1
	fi
}

function getHomeDirForClient() {
	local CLIENT_NAME=$1

	if [ -z "${CLIENT_NAME}" ]; then
		echo "Ошибка: getHomeDirForClient() требует имя клиента в качестве аргумента"
		exit 1
	fi

	# Домашний каталог пользователя, в котором будет записана конфигурация клиента
	if [ -e "/home/${CLIENT_NAME}" ]; then
		# если $1 - это имя пользователя
		HOME_DIR="/home/${CLIENT_NAME}"
	elif [ "${SUDO_USER}" ]; then
		# если нет, используйте SUDO_USER
		if [ "${SUDO_USER}" == "root" ]; then
			# Если sudo запущен от root
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
	echo -e "${ЗЕЛЕНЫЙ}Добро пожаловать в установщик WireGuard!${СБРОС}"
	echo ""
	echo "Мы начнем установку WireGuard на вашем сервере."
	echo "Пожалуйста, отвечайте на вопросы, чтобы настроить ваш VPN."

	# Ввод имени нового клиента
	read -p "Имя нового клиента: " -e -i client CLIENT_NAME

	# Проверка существования клиента с таким именем
	if [[ -e "/etc/wireguard/clients/${CLIENT_NAME}.conf" ]]; then
		echo ""
		echo "${КРАСНЫЙ}Клиент с именем ${CLIENT_NAME} уже существует.${СБРОС}"
		exit 1
	fi

	# Выбор IPv4 адреса для VPN сервера
	echo ""
	echo "Выберите, какой IPv4 адрес вы хотите использовать для вашего VPN сервера:"
	echo "   1) Автоматический (текущий IPv4 адрес)"
	echo "   2) Ввести собственный IPv4 адрес"
	read -p "Выбор [1-2]: " -e -i 1 IPV4_CHOICE

	# Ввод собственного IPv4 адреса
	if [[ ${IPV4_CHOICE} == 2 ]]; then
		read -p "Введите IPv4 адрес: " -e IPV4_ADDRESS

		# Проверка валидности введенного IPv4 адреса
		if [[ ! ${IPV4_ADDRESS} =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
			echo ""
			echo "${КРАСНЫЙ}Неверный формат IPv4 адреса.${СБРОС}"
			exit 1
		fi

		# Проверка, что введенный IPv4 адрес не является локальным
		if [[ ${IPV4_ADDRESS} == 127.0.0.* ]] || [[ ${IPV4_ADDRESS} == 10.* ]] || [[ ${IPV4_ADDRESS} == 172.16.* ]] || [[ ${IPV4_ADDRESS} == 192.168.* ]]; then
			echo ""
			echo "${КРАСНЫЙ}Вы ввели локальный IPv4 адрес, который не подходит.${СБРОС}"
			exit 1
		fi
	fi

	# Выбор IPv6 адреса для VPN сервера
	echo ""
	echo "Выберите, какой IPv6 адрес вы хотите использовать для вашего VPN сервера:"
	echo "   1) Автоматический (текущий IPv6 адрес)"
	echo "   2) Ввести собственный IPv6 адрес"
	read -p "Выбор [1-2]: " -e -i 1 IPV6_CHOICE

	# Ввод собственного IPv6 адреса
	if [[ ${IPV6_CHOICE} == 2 ]]; then
		read -p "Введите IPv6 адрес (/128): " -e IPV6_ADDRESS

		# Проверка валидности введенного IPv6 адреса
		if [[ ! ${IPV6_ADDRESS} =~ ^([a-f0-9:]+\/128)$ ]]; then
			echo ""
			echo "${КРАСНЫЙ}Неверный формат IPv6 адреса.${СБРОС}"
			exit 1
		fi
	fi

	# Выбор порта для WireGuard
	echo ""
	echo "Выберите порт для WireGuard (по умолчанию: 51820):"
	read -p "Порт [51820]: " -e -i 51820 WG_PORT

	# Выбор DNS сервера
	echo ""
	echo "Выберите DNS сервер, который будет использоваться клиентами:"
	echo "   1) Текущие системные DNS серверы"
	echo "   2) Ввести другие DNS серверы"
	read -p "Выбор [1-2]: " -e -i 1 DNS_CHOICE

	# Ввод собственных DNS серверов
	if [[ ${DNS_CHOICE} == 2 ]]; then
		read -p "Введите DNS серверы через запятую: " -e DNS_SERVERS
	fi

	# Готовность к началу установки
	echo ""
	echo "Готов к началу установки? [y/n]: "
	read -e CONTINUE
	if [[ ! ${CONTINUE} =~ ^(y|Y)$ ]]; then
		echo "Установка отменена"
		exit 1
	fi
}

function installWireGuard() {
	# Установка WireGuard
	echo ""
	echo -e "${ЗЕЛЕНЫЙ}Установка WireGuard...${СБРОС}"
	apt-get update
	apt-get install -y wireguard

	# Загрузка модуля ядра
	modprobe wireguard

	# Активация модуля при загрузке системы
	echo "wireguard" >> /etc/modules-load.d/modules.conf

	# Установка утилиты wg
	apt-get install -y wireguard-tools

	# Проверка, что WireGuard установлен
	if ! dpkg -l | grep -q wireguard; then
		echo ""
		echo "${КРАСНЫЙ}Установка WireGuard не удалась.${СБРОС}"
		exit 1
	fi
}

function configureFirewall() {
	# Настройка правил iptables
	echo ""
	echo -e "${ЗЕЛЕНЫЙ}Настройка правил iptables...${СБРОС}"

	# Открытие порта для WireGuard
	ufw allow ${WG_PORT}/udp

	# Включение NAT
	sed -i '/net.ipv4.ip_forward=/c\net.ipv4.ip_forward=1' /etc/sysctl.conf
	sysctl -p

	# Настройка правил iptables для маршрутизации трафика через VPN
	iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o $(ip route show | grep -o "dev \K[^ ]+") -j MASQUERADE
	iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	iptables -A FORWARD -m conntrack --ctstate NEW -s 10.0.0.0/24 -j ACCEPT

	# Сохранение правил iptables
	iptables-save > /etc/iptables/rules.v4
}

function generateClientConfig() {
	# Генерация конфигурации для клиента
	echo ""
	echo -e "${ЗЕЛЕНЫЙ}Генерация конфигурации для клиента...${СБРОС}"

	# Создание ключей для клиента
	wg genkey | tee client_private_key | wg pubkey > client_public_key
	WG_CLIENT_PRIVATE_KEY=$(cat client_private_key)
	WG_CLIENT_PUBLIC_KEY=$(cat client_public_key)

	# Создание конфигурационного файла для клиента
	cat > client-wg0.conf <<EOF
[Interface]
PrivateKey = ${WG_CLIENT_PRIVATE_KEY}
Address = 10.0.0.2/24
DNS = 1.1.1.1

[Peer]
PublicKey = ${WG_SERVER_PUBLIC_KEY}
Endpoint = ${SERVER_IP}:${WG_PORT}
AllowedIPs = 0.0.0.0/0,::/0
EOF

	# Очистка временных файлов
	rm -f client_private_key client_public_key

	# Перемещение файла конфигурации для клиента в домашнюю директорию
	mv client-wg0.conf ~/

	# Печать конфигурации для клиента
	echo ""
	echo -e "${ЖЕЛТЫЙ}Конфигурация для клиента создана и доступна по пути: ~/client-wg0.conf.${СБРОС}"
}

function startWireGuard() {
	# Запуск службы WireGuard
	echo ""
	echo -e "${ЗЕЛЕНЫЙ}Запуск службы WireGuard...${СБРОС}"

	# Запуск службы
	systemctl start wg-quick@wg0

	# Активация автозапуска при загрузке системы
	systemctl enable wg-quick@wg0

	# Проверка статуса службы
	if systemctl is-active --quiet wg-quick@wg0; then
		echo ""
		echo -e "${ЗЕЛЕНЫЙ}WireGuard успешно запущен.${СБРОС}"
	else
		echo ""
		echo -e "${КРАСНЫЙ}Не удалось запустить WireGuard.${СБРОС}"
	fi
}

# Установка WireGuard
installWireGuard

# Конфигурирование правил iptables
configureFirewall

# Генерация конфигурации для клиента
generateClientConfig

# Запуск WireGuard
startWireGuard


