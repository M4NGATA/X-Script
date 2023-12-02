#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() {
	echo "$(printBMagenta ' ELIXIR')"
    echo "$(printBYellow 'Вы действительно хотите удалить Elixir') $(printBRedBlink '!!!')"

	echo "$(printBRed '1) Да')"
	echo "$(printBGreen '2) Нет')"
		
	echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
	read -r ans
	case $ans in
		1)
		yes
		;;
		2)
		no
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Elixir/main.sh)
}

yes(){
clear
printlogo
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
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Elixir/main.sh)
		;;
	esac
}

mainmenu