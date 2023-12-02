#!/bin/bash
# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта
	echo "$(printBMagenta ' НОДЫ')"
# Основное меню
	mainmenu() {
		echo "$(printBGreen ' 1 ')Zora"
		echo "$(printBGreen ' 2 ')Shardeum"
		echo "$(printBGreen ' 3 ')Elixir"
		echo "$(printBGreen ' 4 ')Holograph"
		echo ' ---------'
		echo "$(printBYellow ' 9)') $(printBYellow 'Архив')"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
#	Свойства меню
			read -r ans
				case $ans in
			1)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Zora/main.sh)
			;;
			
			2)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Shardeum/main.sh)
			;;

			3)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Elixir/main.sh)
			;;

			4)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Holograph/main.sh)
			;;

			9)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/archive_nodes.sh)
			;;

			0)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/start.sh)
			;;

			10)
			echo $(printBCyan '	"Bye bye."') && exit
			;;

			*)
			clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
			;;
		esac
		}

mainmenu