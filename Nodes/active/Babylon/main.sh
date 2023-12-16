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
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Babylon/dellet.sh)
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
	echo Проект использует безопасность Биткойна для повышения безопасности цепочек в экосистеме Cosmos.
	echo Целью является создание децентрализованной экосистемы, защищенной биткойнами. 
	echo Раунд финансирования в размере 18 миллионов долларов, завершился. 
	echo Раунд проводился совместно Polychain Capital и Hack VC при участии Framework Ventures,   
	echo Polygon Ventures, Castle Island Ventures, OKX Ventures, Finality Capital, Breyer Capital, Symbolic Capital и IOSG.
	echo
	echo Проект работает как посредник между блокчейнами Cosmos, нуждающимися в дополнительной безопасности, и Биткойном. 
	echo Babylon берет заголовки блоков — идентифицирующие недавно подтвержденный блок — из цепочек, использующих его сервисы, 
	echo и записывает эти заголовки в блокчейн Биткойна. Это означает, что любой может проверить Биткойн и увидеть, 
	echo что блок был подтвержден, обеспечивая дополнительную безопасность того, что транзакции внутри блока произошли.
	echo "$(printBYellow ' -------------------------------------')"
	mainmenu
}


mainmenu