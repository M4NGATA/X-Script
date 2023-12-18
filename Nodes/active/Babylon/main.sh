#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() { 
		echo "$(printBYellow ' BABYLON')"
		echo "$(printBGreen ' 1 ')Управление"
		echo "$(printBGreen ' 2 ')Обновить"
		echo "$(printBGreen ' 3 ')Установить"
		echo "$(printBGreen ' 4 ')Удалить"
		echo "$(printBGreen ' 5 ')Инфо"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
#	Свойства меню
read -r ans
	case $ans in
		1)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Babylon/control.sh)
		;;
		2)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Babylon/update.sh)
		;;
		3)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Babylon/install.sh)
		;;
		4)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Babylon/delet.sh)
		;;
		5)
		info
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

 

info(){
	clear && printlogo
	echo "$(printBYellow ' -------------------------------------')"
	echo Babylon — это новый проект Cosmos, цель которого — использовать безопасность
	echo Биткойна для повышения безопасности зон Cosmos и других цепочек PoS. Команда
	echo Babylon утверждает, что они являются первой площадкой, предлагающей биткойн 
	echo миру PoS. Протокол стейкинга биткойна от Babylon предоставляет способ внедрения
	echo биткойна в качестве стейкинг-актива для цепей PoS.
	echo "$(printBYellow ' -------------------------------------')"
	mainmenu
}


mainmenu