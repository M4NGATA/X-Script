#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() {	
		echo "$(printBBlue ' HOLOGRAPH')"
		echo "$(printBGreen ' 1 ')Просмотр текущей конфигурации сети."
		echo "$(printBGreen ' 2 ')Просмотр текущей информации о пользователе."
		echo "$(printBGreen ' 3 ')Просмотр конфигурации Holograph CLI."
		echo "$(printBGreen ' 4 ')Обновить конфиг Holograph CLI."
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
#	Свойства меню
	read -r ans
	case $ans in
		1)
		clear && printlogo
		echo
		holograph config:networks
		echo
		mainmenu
		;;
		
		2)
		clear && printlogo
		echo
		holograph config:user
		echo
		mainmenu
		;;

		3)
		clear && printlogo
		echo
		holograph config:view
		echo
		mainmenu
		;;
		
		4)
		clear && printlogo
		echo
		holograph config
		echo
		mainmenu
		;;

		0)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/Holograph/main.sh)
		;;
		
		10)
		echo $(printBCyan '	"Bye bye."') && exit
		;;
		
		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
		;;
	esac
}

back(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/holograph/main.sh)
}

mainmenu