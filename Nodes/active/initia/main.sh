#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() { 
		echo "$(printBMagenta 'Initia')"
        echo "$(printBGreen ' 1 ')Управление"
        echo "$(printBGreen ' 2 ')Установить Initia"
        echo "$(printBGreen ' 3 ')Установить Oracle"
		echo "$(printBGreen ' 4 ')Удалить"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
#	Свойства меню
read -r ans
	case $ans in
		1)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/initia/controls.sh)
		;;
		2)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/initia/install_node.sh)
		;;
		3)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/initia/install_oracle.sh)
		;;
		4)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/initia/delete.sh)
		;;
		0)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_nodes.sh)
		;;
		10)
		echo $(printBCyan '	"Bye bye."') && exit
		;;
		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
		;;
	esac
}


