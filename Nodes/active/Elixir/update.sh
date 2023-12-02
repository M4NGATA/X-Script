#!/bin/bash
# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта
	echo "$(printBMagenta ' ELIXIR')"
# Основное меню
docker kill ev
docker rm ev
docker pull elixirprotocol/validator:testnet-2
docker build . -f Dockerfile -t elixir-validator
docker run -d --restart unless-stopped --name ev elixir-validator

mainmenu(){
	echo -ne "
    $(printBCyan '	Обновление завершено!')  
	$(printBCyan '	Для возврата нажмите Enter: ')  "
		read -r ans
			case $ans in
				*)
				source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Elixir/main.sh)
				;;
			esac
}

mainmenu