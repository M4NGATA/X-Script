#!/bin/bash
# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта
	echo "$(printBMagenta ' SHARDEUM')"
# Основное меню
mainmenu() {
	echo "$(printBGreen 'CLI')"
	echo "$(printBGreen ' 1 ')Stake"
	echo "$(printBGreen ' 2 ')Unstake"
	echo "$(printBGreen ' 3 ')Stake Info"
	echo "$(printBGreen 'Validator')"
	echo "$(printBGreen ' 4 ')Validator status"
	echo "$(printBGreen ' 5 ')pm2 list"
	echo "$(printBGreen ' 6 ')Version info"
	echo "$(printBGreen ' 7 ')Autostart Validator"
	echo "$(printBGreen 'Connect Wallet')"
	echo "$(printBGreen ' 8 ')Ввести адрес Metamask"
	echo "$(printBGreen ' 9 ')Ввести закрытый ключ Metamask"
	echo "$(printBGreen 'System')"
	echo "$(printBGreen ' 11 ')Operator GUI start"
	echo "$(printBGreen ' 12 ')Operator CLI start"
	echo ' --------'
	echo "$(printBBlue '  0 ')Назад"
	echo "$(printBRed ' 10 ')Выход"
	echo ' --------'
	echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
#	Свойства меню
	read -r ans
	case $ans in
		1)
		stake
		;;

		2)
		Unstake
		;;

		3)
		stakeinfo
		;;

		4)
		status
		;;

		5)
		pm2
		;;

		6)
		version
		;;

		7)
		autostart
		;;

		8)
		metamask
		;;

		9)
		privkey
		;;

		11)
		guistart
		;;

		12)
		clistart
		;;

		0)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Shardeum/main.sh)
		;;

		10)
		echo $(printBCyan '"Bye bye."') && exit
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
		;;
	esac
}


autostart() {

  cd "$HOME"

  if ! command -v screen &> /dev/null; then
    echo "Установка пакета screen..."
    sudo apt-get update
    sudo apt-get install screen
  fi

  curl -sS -o autostart_shardeum.sh https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Shardeum/autostart_shardeum.sh && chmod +x autostart_shardeum.sh
  screen -dmS autostart_shardeum bash autostart_shardeum.sh
  printlogo
  echo
  echo "    Автостарт валидатора запущен в screen!"
  echo
  mainmenu
}

stake(){
	clear && printlogo
	echo
	read -r -p "
$(printCyan 'Введите количество монет SHM :')  " VAR2
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "export PRIV_KEY="$PRIV_KEY" && operator-cli stake "$VAR2""
	echo
	mainmenu
}

unstake(){
	clear && printlogo
	echo
	read -r -p "
$(printBYellow 'Вы можете вывести все монеты со стейка просто нажав Enter или
		 введите нужное количество монет SHM:')  " VAR1
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "export PRIV_KEY="$PRIV_KEY" && operator-cli unstake "$VAR1""
	echo
	mainmenu
}
stakeinfo(){
	clear && printlogo
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli stake_info "$METAMASK""
	echo
	mainmenu
}

status(){
	clear && printlogo
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli status"
	echo
	mainmenu
}

pm2(){
	clear && printlogo
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "pm2 ls"
	echo
	mainmenu
}

version(){
	clear && printlogo
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli version"
	echo
	mainmenu
}

privkey(){
	clear && printlogo
	echo -ne "
$(printCyan 'Вставте приватный ключ Metamask') "
	read -r PRIV_KEY
	echo "export PRIV_KEY="$PRIV_KEY"" >> ~/.bash_profile && source ~/.bash_profile
	echo
	mainmenu
}

metamask(){
	clear && printlogo
	echo -ne "
$(printCyan 'Вставте адрес Metamask') "
	read -r METAMASK
	echo "export METAMASK="$METAMASK"" >> ~/.bash_profile && source ~/.bash_profile
	echo
	mainmenu
}

guistart(){
	clear && printlogo
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli gui start"
	echo
	mainmenu
}

clistart(){
	clear && printlogo
	echo
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli start"
	echo
	mainmenu
}

mainmenu