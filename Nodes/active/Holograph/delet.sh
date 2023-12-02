#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() {
	echo "$(printBBlue ' HOLOGRAPH')"
	echo "$(printBRed    'Вы действительно хотите удалить Holograph ') $(printBRedBlink '!!!')"
	  
	echo "$(printRed   '1) Да')"
	echo "$(printGreen '2) Нет')"
		
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
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/Holograph/main.sh)
}

yes(){
clear
printlogo
echo -ne "	

$(printBYellow 'Удаляем.....!')"

rm -rf .config	
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Holograph удален с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/Holograph/main.sh)
		;;
	esac
}


mainmenu