#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() {
	echo "$(printBRed ' ZORA')"
	echo "$(printBGreen ' 1 ')Установить"
	echo "$(printBGreen ' 2 ')Удалить ноду"
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