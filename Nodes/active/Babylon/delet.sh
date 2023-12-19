#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() { 
	echo "$(printBYellow ' BABYLON')"
  	echo "$(printBYellow 'Вы действительно хотите удалить Babylon') $(printBRedBlink '!!!')"

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
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Babylon/main.sh)
}

yes(){
clear && printlogo
echo -ne "	

$(printBYellow 'Удаляем.....!')"
cd $HOME
sudo systemctl stop babylon.service
sudo systemctl disable babylon.service
sudo rm /etc/systemd/system/babylon.service
sudo systemctl daemon-reload
rm -f $(which babylond)
rm -rf $HOME/.babylond
rm -rf $HOME/babylon
submenu
}

submenu(){
	echo -ne "
	$(printBGreen    'Babylon полностью удален с вашего сервера ')$(printBGreenBlink '!!!')
	
	Нажмите Enter:  "
	read -r ans
	case $ans in
		*)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Babylon/main.sh)
		;;
	esac
}

mainmenu

