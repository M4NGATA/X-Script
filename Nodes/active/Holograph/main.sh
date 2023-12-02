#!/bin/bash

#Script written by DZHAGERR for X-libra

#-----------------------------Подгрузка общих функций и цвета-----------------------------#
	clear && source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/function/common.sh) && printlogo && printholograph
#-----------------------------------------------------------------------------------------#
mainmenu() { 

		echo "$(printBGreen ' 1 ')Faucet"

		echo "$(printBGreen ' 2 ')Start operator"
		echo "$(printBGreen ' 3 ')Bonding"
		
		echo "$(printBGreen ' 4 ')Управление"

		echo "$(printBGreen ' 5 ')Установить ноду"
		echo "$(printBGreen ' 6 ')Удалить ноду"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
#	Свойства меню
read -r ans
	case $ans in
		1)
		faucet
		;;
		
		2)
		operator
		;;

		3)
		bonding
		;;
		
		4)
		control
		;;

		5)
		install
		;;
		
		6)
		delet
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

delet(){
	source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Holograph/delet.sh)
}

operator(){
	clear && printlogo
	echo
	holograph operator
	echo
	mainmenu
}


faucet(){
	echo
	holograph faucet
	echo
	mainmenu
}

bonding(){
	holograph operator:bond
}

install(){
	source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Holograph/install.sh)
}

control(){
	source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Holograph/control.sh)
}



mainmenu