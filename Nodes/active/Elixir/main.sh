#!/bin/bash
# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() { 
		echo "$(printBMagenta ' ELIXIR')"
		echo "$(printBGreen ' 1 ')Установить"
		echo "$(printBGreen ' 2 ')Обновить"
		echo "$(printBGreen ' 3 ')Просмотр логов"
		echo "$(printBGreen ' 4 ')Удалить"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
#	Свойства меню
read -r ans
	case $ans in
		1)
		install
		;;
		2)
		update
		;;
		3)
		logs
		;;
		4)
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

install(){
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Elixir/install.sh)
}

# control(){
# source <(curl -s )
# }

logs(){
	docker logs -f --tail 100 ev
	mainmenu
}

update(){
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Elixir/update.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Elixir/delet.sh)
}

mainmenu