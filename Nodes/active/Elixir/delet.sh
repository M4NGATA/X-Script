#!/bin/bash
# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта
	echo "$(printBMagenta ' ELIXIR')"
# Основное меню
mainmenu() {
    echo -ne "
    
	  $(printBRed    'Вы действительно хотите удалить Elixir ') $(printBRedBlink '!!!')
	  
		$(printRed   '1) Да')
		$(printGreen '2) Нет')
		
	  $(printBCyan 'Введите цифру:') "
	read -r ans
	case $ans in
		1)
		yes
		;;
		2)
		no
		;;

		*)
		clear
		printlogo
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/elixir/main.sh)
}

yes(){
clear
printlogo
printelixir
echo -ne "	

$(printBYellow 'Удаляем.....!')"
cd $HOME
docker kill ev
docker rm ev
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Elixir полностью удален с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/elixir/main.sh)
		;;
	esac
}


mainmenu