#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() {
	echo "$(printBMagenta ' SHARDEUM')"
	echo "$(printGreen  '-----------------------------------------')"
	echo "$(printYellow 'Минимальные требования к оборудованию.')"
	echo "$(printBCyan '	  4CPU 8RAM 200GB')"
	echo "$(printGreen  '-----------------------------------------')"
	echo "$(printYellow 'Рекомендуемые требования к оборудованию.')"
	echo "$(printBCyan '	  8CPU 16RAM 400GB')"
	echo "$(printGreen  '-----------------------------------------')"
	echo "$(printCyan	'Вы действительно хотите начать установку') $(printCyanBlink '???')"
	echo "$(printGreen	' 1) Да')"
	echo "$(printRed	' 2) Нет')"
	echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
	read -r ans
	case $ans in
		1)
		yes
		;;
		2)
		no
		;;
		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
        ;;
    esac
}


no(){
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Shardeum/main.sh)
}
yes(){
clear
printlogo
echo



printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Обновление менеджеров пакетов........" && sleep 1
	sudo apt update > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	sudo apt install curl screen npm -y
printGreen "Готово!" && sleep 1

printYellow "3. Устанавливаем докер........" && sleep 1
	sudo apt install docker.io -y
	docker --version
printGreen "Готово!" && sleep 1

printYellow "4. Устанавливаем докер-компоновку........" && sleep 1
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	docker-compose --version
printGreen "Готово!" && sleep 1

printYellow "5. Установка валидатора ........" && sleep 1
	curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
printGreen "Готово!" && sleep 1

printYellow "6. Запуск валидатора ........" && sleep 1
	docker update --restart always shardeum-dashboard && docker start shardeum-dashboard && docker exec -i shardeum-dashboard /bin/bash -c "operator-cli gui start && operator-cli start" && curl -sS -o autostart_shardeum.sh https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/shardeum/autostart_shardeum.sh && chmod +x autostart_shardeum.sh && screen -dmS autostart_shardeum bash autostart_shardeum.sh
printGreen "Готово!" && sleep 1
docker exec -i shardeum-dashboard /bin/bash -c "pm2 list"
screen -ls
subnmenu

}

subnmenu() {
	echo -ne "
	$(printCyan	'Установка завершена') $(printCyanBlink '!!!')
	$(printCyan	'Нажмите Enter:') "
	read -r ans
	case $ans in
		*)
		exit
        ;;
    esac
}

mainmenu