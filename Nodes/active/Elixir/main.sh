#!/bin/bash
# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта
	echo "$(printBMagenta ' ELIXIR')"
# Основное меню
mainmenu() { echo -ne "
		$(printBCyan ' -->') $(printBGreen    '1) Установить')
		$(printBCyan ' -->') $(printBYellow    '2) Обновить')
		$(printBCyan ' -->') $(printBGreen    '3) Просмотр логов')
		$(printBCyan ' -->') $(printBRed    '4) Удалить')

		$(printBBlue ' <-- 5) Назад')
		$(printBRed        '     0) Выход')

	$(printCyan 'Введите цифру:')  "

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
		5)
		back
		;;
		0)
		echo $(printBCyan '	"Bye bye."')
		rm x-l1bra
		exit
		;;
		*)
		clear
		printlogo
		printelixir
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

install(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/elixir/install.sh)
}

# control(){
# source <(curl -s )
# }

logs(){
	docker logs -f --tail 100 ev
	mainmenu
}

update(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/elixir/update.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/elixir/delet.sh)
}

back(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menunodes.sh)
}

mainmenu