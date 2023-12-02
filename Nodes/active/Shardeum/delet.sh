#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() {
	echo "$(printBCyan ' SHARDEUM')"
    echo -ne "

	  $(printBRed    'Вы действительно хотите удалить Shardeum ') $(printBRedBlink '!!!')

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
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
		;;
	esac
}

no(){
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Shardeum/main.sh)
}

yes(){
clear
printlogo
echo -ne "

$(printBYellow 'Удаляем.....!')"
cd ~/.shardeum
./cleanup.sh
cd ~/
rm -rf .shardeum
rm installer.sh
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Shardeum полностью удалена с вашего сервера ')$(printBGreenBlink '!!!')

	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Shardeum/main.sh)
		;;
	esac
}


mainmenu