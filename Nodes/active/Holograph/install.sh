#!/bin/bash
# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта

mainmenu() {
		echo "$(printBYellow ' HOLOGRAPH')"
	echo "$(printGreen  '-----------------------------------------')"
	echo "$(printYellow 'Минимальные требования к оборудованию.')"
	echo "$(printBCyan '	  4CPU 4RAM 40GB')"
	echo "$(printGreen  '-----------------------------------------')"
	echo "$(printYellow 'Рекомендуемые требования к оборудованию.')"
	echo "$(printBCyan '	  8CPU 4RAM 200GB')"
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
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/Holograph/main.sh)
}
yes(){
clear && printlogo
echo


printBCyan "Пожалуйста подождите........" && sleep 1
printYellow "1. Обновление менеджеров пакетов........" && sleep 1
	sudo apt update > /dev/null 2>&1
printGreen "Готово!" && sleep 1


printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	sudo apt install npm screen make clang git pkg-config libssl-dev build-essential git gcc chrony curl jq ncdu bsdmainutils htop net-tools lsof fail2ban wget screen  -y
	curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
	apt install nodejs -y
printGreen "Готово!" && sleep 1

printYellow "3. Устанавка Holograph cli........" && sleep 1
npm install -g @holographxyz/cli
printGreen "Готово!" && sleep 1

printYellow "4. Запускаем config........" && sleep 1
holograph config
printGreen "Готово!" && sleep 1

subnmenu

}

subnmenu() {
	echo -ne "
	$(printCyan	'Установка завершена') $(printCyanBlink '!!!')
	$(printCyan	'Нажмите Enter:') "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/Holograph/main.sh)
       		;;
    esac
}

mainmenu