#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
	mainmenu() { 
		echo "$(printBMagenta ' СМАРТКОНТРАКТЫ')" 
		echo "$(printBGreen ' 1 ')ZkSync"
		echo "$(printBGreen ' 2 ')Holograph"
		echo ' ---------'
		echo "$(printBYellow ' 9)') $(printBYellow 'Архив')"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
		read -r ans
			case $ans in

			1)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/smartcontract/zkSync.sh)
			;;

			2)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/smartcontract/holograph.sh)
			;;

			9)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/archive_smart.sh)
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