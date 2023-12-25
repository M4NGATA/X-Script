#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() {
	echo "$(printBRed 'НАСТРОЙКА ПОРТОВ')"
 	echo "$(printBGreen ' 1 ')Просмотр активных портов"
	echo "$(printBGreen ' 2 ')Открыть порт"
	echo "$(printBGreen ' 3 ')Закрыть порт"
	echo "$(printBGreen ' 4 ')Проверить статус портов"
	echo ' --------'
	echo "$(printBBlue '  0 ')Назад"
	echo "$(printBRed ' 10 ')Выход"
	echo ' --------'
	echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
#	Свойства меню
	read -r ans
		case $ans in
		
		1)
  		clear && printlogo && echo "$(printBRed 'Просмотр открытых портов')"
  		netstat -tupln | grep LISTEN
    		mainmenu
  		;;
		
		2)
  		clear && printlogo
		echo -n "Введите номер порта для открытия: "
		read port
		sudo ufw allow $port
		echo "Порт $port открыт"
		mainmenu
		;;

		3)
  		clear && printlogo
		echo -n "Введите номер порта для закрытия: "
		read port
		sudo ufw deny $port
		echo "Порт $port закрыт"
		mainmenu
		;;

		4)
		clear && printlogo && echo && sudo ufw status numbered
		mainmenu
		;;

		0)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Function/server/server.sh)
		;;

		10)
		echo $(printBCyan '"Bye bye."') && exit
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
		;;

		esac
}

mainmenu
