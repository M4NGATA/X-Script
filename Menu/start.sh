#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
	mainmenu() {
		echo "$(printBMagenta ' ОСНОВНОЕ МЕНЮ')"
		echo "$(printBGreen ' 1 ')Ноды"
		echo "$(printBGreen ' 2 ')Смартконтракты"
		echo "$(printBGreen ' 3 ')Сервер"
		echo ' --------'
		echo "$(printBRed ' 10 ')Выход"
		echo ' --------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
#	Свойства меню
	read -r ans
		case $ans in

			1)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_nodes.sh)
			;;

			2)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_smart.sh)
			;;

			3)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/server/server.sh)
			;;
			
			10)
			echo $(printBCyan '"Bye bye."') && exit
			;;
			
			*)
			clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
			;;
	esac
}

mainmenu
