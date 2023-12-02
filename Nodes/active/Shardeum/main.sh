#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() {
	echo "$(printBCyan ' SHARDEUM')"
		echo "$(printBGreen ' 1 ')Управление"
		echo "$(printBGreen ' 2 ')Установить"
		echo "$(printBGreen ' 3 ')Обновить Validator"
		echo "$(printBGreen ' 4 ')Обновить CLI/GUI"
		echo "$(printBGreen ' 5 ')Удалить ноду"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
#	Свойства меню
read -r ans
	case $ans in
		1)
		control
		;;

		2)
		install
		;;

		3)
		update
		;;

		4)
		updatecli
		;;

		5)
		delet
		;;

		0)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_nodes.sh)
		;;

		10)
		echo $(printBCyan '"Bye bye."') && exit
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
		;;
	esac
}

install(){
 source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Shardeum/install.sh)
}

control(){
	source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Shardeum/control.sh)
}

delet(){
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Shardeum/delet.sh)
}


updatecli(){
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli stop"
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli update"
	mainmenu
}


#--------------ОБНОВЛЕНИЕ 1.1.6
update(){
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
	cd $HOME
	docker exec -i shardeum-dashboard /bin/bash -c "operator-cli stop"
	curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
	docker update --restart always shardeum-dashboard && docker start shardeum-dashboard && docker exec -i shardeum-dashboard /bin/bash -c "operator-cli gui start && operator-cli start" && docker exec -i shardeum-dashboard /bin/bash -c "pm2 list" && screen -ls
	echo -ne "
			    $(printBGreen    'Обновление завершено!')

			    Проверить работу ноды можно командой:
			    $(printBYellow 'pm2 list')"

	mainmenu

}

# fixinstall(){
# 	cd
#     docker exec -i shardeum-dashboard /bin/bash -c "rm -rf cli gui"
# 	docker exec -i shardeum-dashboard /bin/bash -c "sudo chown -R node /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share"
# 	docker exec -i shardeum-dashboard /bin/bash -c "./entrypoint.sh"
# 	exit
# 	mainmenu
# }



mainmenu