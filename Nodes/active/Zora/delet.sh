#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() {
	echo "$(printBBlue ' ZORA')"
	echo "$(printBRed    'Вы действительно хотите удалить Zora ') $(printBRedBlink '!!!')"
	  
	echo "$(printRed   '1) Да')"
	echo "$(printGreen '2) Нет')"
		
	  echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
	read -r ans
	case $ans in
		1)
		yes
		;;
		2)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Zora/main.sh)
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
		;;
	esac
}

yes(){
clear
printlogo
echo -ne "	

$(printBYellow 'Удаляем.....!')"
docker rm -f node_node_1
docker rm -f node_geth_1
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Zora удалена с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Zora/main.sh)
		;;
	esac
}


mainmenu