#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
	mainmenu() { 
		echo "$(printBYellow ' АРХИВ СМАРТКОНТРАКТОВ')"
		echo ' --------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' --------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
		read -r ans
			case $ans in

			0)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_smart.sh)
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