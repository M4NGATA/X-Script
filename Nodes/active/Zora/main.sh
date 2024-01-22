#!/bin/bash

clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo

mainmenu() {
    echo "$(printBCyan ' ZORA')"
    echo "$(printBGreen ' 1 ')Установить"
    echo "$(printBGreen ' 2 ')Удалить"
	echo "$(printBGreen ' 3 ')Инфо"
    echo ' ---------'
    echo "$(printBBlue '  0 ')Назад"
	echo "$(printBRed ' 10 ')Выход"
	echo ' ---------'
	echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
#	Свойства меню
read -r ans
	case $ans in
		1)
		    install
		;;

		2)
		    delet
		;;

		3)
		    info
		;;

		0)
		    source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_nodes.sh)
		;;

		10)
		    echo $(printBCyan '"Bye bye."') && exit
		;;

		*)
		    clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
		;;
	esac
}


install(){
    source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Zora/install.sh)
}

delet(){
	source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Zora/delet.sh)
}

info(){
	clear && printlogo
	echo "$(printBYellow ' -------------------------------------')"
	echo Сеть Zora - это быстрая, экономичная и масштабируемая Layer 2,
	echo Многие Layer 2 в настоящее время ориентированы на DeFi, тогда как
	echo сеть Zora представляет собой экосистему, в которой приоритет отдается NFT.
	echo "$(printBYellow ' -------------------------------------')"
	mainmenu
}

   
mainmenu