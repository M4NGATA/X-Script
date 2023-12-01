#!/bin/bash

# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта
	echo "$(printBMagenta ' ОСНОВНОЕ МЕНЮ')"
# Основное меню
	mainmenu() {
		echo "$(printBGreen ' 1 ')Новости"
		echo "$(printBGreen ' 2 ')Ноды"
		echo "$(printBGreen ' 3 ')Смартконтракты"
		echo "$(printBGreen ' 4 ')Сервер"
		echo ' --------'
		echo "$(printBRed ' 10 ')Выход"
		echo ' --------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
#	Свойства меню
	read -r ans
		case $ans in

			1)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/news.sh)
			;;

			2)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_nodes.sh)
			;;

			3)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_smart.sh)
			;;

			4)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/server/server.sh)
			;;
			
			10)
			echo $(printBCyan '"Bye bye."')
			exit
			;;
			
			*)
			clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
			;;

	esac
}

mainmenu