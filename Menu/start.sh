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
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menunodes.sh)
			;;

			3)
			help
			;;

			4)
			server
			;;

			5)
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