#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
	mainmenu() {
		echo "$(printBGreen ' СЕРВЕР')"
		echo "$(printBGreen ' 1 ')Показать IP сервера"
		echo "$(printBGreen ' 2 ')Системный монитор"
		echo "$(printBGreen ' 3 ')Базовая настройка сервера"
		echo "$(printBGreen ' 4 ')Настройка прокси"
		echo "$(printBGreen ' 5 ')Настройка портов"
		echo ' --------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' --------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
#	Свойства меню
	read -r ans
		case $ans in

			1)
			clear && printlogo && echo "$(printBYellow 'ВАШ IP')" && echo "$(printBYellow '--------------')" && curl https://ipinfo.io/ip && echo && echo "$(printBYellow '--------------')" && mainmenu
			;;

			2)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/server/sm.sh)
			;;

			3)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/server/base_setting.sh)
			;;

			4)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/server/dante_proxy.sh)
			;;

			5)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/server/ports.sh)
			;;

			0)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/start.sh)
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