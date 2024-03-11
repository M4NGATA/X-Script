#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
	mainmenu() {
		echo "$(printBMagenta ' НОДЫ')"
		echo "$(printBGreen ' 1 ')Babylon"
		echo "$(printBGreen ' 2 ')Shardeum"
		echo "$(printBGreen ' 3 ')Elixir"
		echo "$(printBGreen ' 4 ')Zora"
		echo "$(printBGreen ' 5 ')Holograph"
		echo "$(printBGreen ' 6 ')Taiko"
		echo ' ---------'
		echo "$(printBYellow ' 9)') $(printBYellow 'Архив')"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
#	Свойства меню
	read -r ans
		case $ans in
			1) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Babylon/main.sh) ;;
			2) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Shardeum/main.sh) ;;
			3) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Elixir/main.sh) ;;
			4) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Zora/main.sh) ;;
			5) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Holograph/main.sh) ;;
			6) clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/main.sh) ;;
			9) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/archive_nodes.sh) ;;
			0) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/start.sh) ;;
			10) echo $(printBCyan '	"Bye bye."') && exit ;;
			*) clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu ;;
		esac
		}

mainmenu