#!/bin/bash

# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта
	echo "$(printBMagenta ' СЕРВЕР')"
# Основное меню
	mainmenu() {
		echo "$(printBGreen ' 1 ')Системный монитор"
		echo "$(printBGreen ' 2 ')Прокси"
		echo "$(printBGreen ' 3 ')Настройка портов"
		echo "$(printBGreen ' 4 ')VPN"
		echo ' --------'
		echo "$(printBRed ' 9 ')Назад"
		echo "$(printBRed ' 0 ')Выход"
		echo ' --------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
#	Свойства меню
	read -r ans
		case $ans in

			1)
			install
			;;

			2)
			status
			;;

			3)
			help
			;;

			4)
			server
			;;

			9 )
			back
			;;

			*)
			clear && printlogo
			echo "$(printBRed ' Неверный запрос!')"
			mainmenu
			;;

	esac
}

# функции


mainmenu