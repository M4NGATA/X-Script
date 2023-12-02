#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() {
	echo "$(printBGreen ' БАЗОВАЯ НАСТРОЙКА СЕРВЕРА')"
	echo "$(printBYellow	'Эта функция произведет базовую настройку сервера.')"
    echo "Будут установлены пакеты, требуемые для большинства"
    echo "нод, также она настроит защиту от D-Dos атак "
    echo "и включит Firewall, с помощью которого вы сможете"
    echo "управлять портами."
    echo "$(printGreen	'------------------')"
    echo "$(printBYellow	'Желаете продолжить?')"
    echo "$(printGreen	'------------------')"
	echo "$(printGreen	' 1 ')Да"
	echo "$(printRed	' 2 ')Нет"
	echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
	read -r ans
	case $ans in
		1)
		yes
		;;
		2)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/server/server.sh)
		;;
		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
        ;;
    esac
}

yes() {
    sudo apt-get update && sudo apt upgrade -y && apt-get -y install console-cyrillic git wget fail2ban net-tools nano ufw bash-completion fail2ban && ufw enable && systemctl enable fail2ban && systemctl start fail2ban
    printlogo && echo "$(printBGreen 'ГОТОВО ;) ')" && submenu
}

submenu(){
    	echo -ne "Нажмите Enter: "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/server/server.sh)
        ;;
    esac
}


mainmenu