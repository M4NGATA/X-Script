#!/bin/bash
# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта
	echo "$(printBMagenta ' NIBIRU -> BACKUP')"
# Основное меню
	mainmenu() {
		echo "$(printBGreen ' 1 ')Сохранить валидатора"
		echo "$(printBGreen ' 2 ')Восстановить валидатора"
		echo ' ---------'
		echo "$(printBBlue ' 0)') $(printBYellow 'Назад')"
		echo "$(printBRed ' 10) Выход')"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
#	Свойства меню
read -r ans
	case $ans in
		1)
		backup
		;;

		2)
		again
		;;

		3)
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
		printnibiru
		echo
		echo
		echo    -ne "$(printRed '		   Неверный запрос !')"
		echo
		mainmenu
		;;
	esac
}

backup(){
	mkdir $HOME/backups_nibiru
	cp $HOME/.nibid/data/priv_validator_state.json $HOME/backups_nibiru/priv_validator_state.json.backup
	cp $HOME/.nibid/config/priv_validator_key.json $HOME/backups_nibiru/priv_validator_key.json.backup
	clear && printlogo && printnibiru
	echo -ne "
		Валидатор сохранен!
		Резервная копия находится в папке backups_defund "
	echo
	mainmenu
}

again(){
	systemctl stop nibid.service
	cp $HOME/backups_nibiru/priv_validator_state.json.backup $HOME/.nibid/data/priv_validator_state.json
	cp $HOME/backups_nibiru/priv_validator_key.json.backup $HOME/.nibid/config/priv_validator_key.json
	systemctl start nibid.service
	clear && printlogo && printnibiru
	echo -ne "
		Валидатор востановлен!
	"
	echo
	mainmenu
}

back(){
	source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/nibiru/control.sh)
}


mainmenu