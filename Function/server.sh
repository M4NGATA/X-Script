#!/bin/bash

# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта
	echo "$(printBMagenta ' СЕРВЕР')"
# Основное меню
	mainmenu() {
		echo "$(printBGreen ' 1 ')Системный монитор"
		echo "$(printBGreen ' 2 ')Настройка прокси"
		echo "$(printBGreen ' 3 ')Настройка портов"
		echo "$(printBGreen ' 4 ')VPN"
		echo ' --------'
		echo "$(printBRed ' 0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' --------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
#	Свойства меню
	read -r ans
		case $ans in

			1)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/sm.sh
			;;

			2)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/dante_proxy.sh
			;;

			3)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/ports.sh
			;;

			4)
			clear && printlogo && echo "$(printBYellow ' Coming soon!')" && mainmenu
			;;

			0)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/start.sh)
			;;
			
			10)
			exit
			;;
			
			*)
			clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
			;;

	esac
}


mainmenu