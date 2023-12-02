#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
    mainmenu() {
		echo "$(printBMagenta ' ELIXIR')"
		echo "$(printGreen  '-----------------------------------------')"
		echo "$(printYellow 'Минимальные требования к оборудованию.')"
		echo "$(printBCyan '	4CPU 8RAM 200GB')"
		echo "$(printGreen  '-----------------------------------------')"
	    echo "$(printCyan	'Вы действительно хотите начать установку') $(printCyanBlink '???')"
	    echo "$(printGreen	' 1) Да')"
	    echo "$(printRed	' 2) Нет')"
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
###############     ВОЗВРАТ В МЕНЮ
    no(){
    source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Elixir/main.sh)
    }
###############     ПРОЦЕС УСТАНОВКИ
    yes(){
    clear && printlogo && echo

    printBCyan "Пожалуйста подождите........" && sleep 1
    printYellow "1. Обновление менеджеров пакетов........" && sleep 1
	    sudo apt update > /dev/null 2>&1
    printGreen "Готово!" && sleep 1

    printYellow "2. Устанавливаем дополнительные пакеты........" && sleep 1
	    sudo apt install curl docker.io -y && docker --version &&
    printGreen "Готово!" && sleep 1

    printYellow "4. Устанавливаем докер-компоновку........" && sleep 1
	    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	    sudo chmod +x /usr/local/bin/docker-compose && docker-compose --version
    printGreen "Готово!" && sleep 1

    printYellow "5. Установка валидатора ........" && sleep 1



	    # curl -O https://files.elixir.finance/Dockerfile && 

read -r -p " Введите имя валидатора:  " VALIDATOR_NAME
read -r -p " Введите адрес Metamask:  " METAMASK_ADDRESS
read -r -p " Введите приватный ключ Metamask:  " PRIVATE_KEY_ELIXIR

cat << EOF > $HOME/Dockerfile
FROM elixirprotocol/validator:testnet-2

ENV ADDRESS=$METAMASK_ADDRESS
ENV PRIVATE_KEY=$PRIVATE_KEY_ELIXIR
ENV VALIDATOR_NAME=$VALIDATOR_NAME
EOF
docker build . -f Dockerfile -t elixir-validator
    printGreen "Готово!" && sleep 1
    printYellow "6. Запуск валидатора ........" && sleep 1
        docker run -d --restart unless-stopped --name ev elixir-validator
    printGreen "Готово!" && sleep 1
      
    submenu
    }


submenu(){
echo -ne "
	$(printBGreen    'УСТАНОВКА ЗАВЕРШЕНА........') $(printBGreenBlink '!!!')
	
	$(printBCyan 'Нажмите Enter:')  "
	read -r ans
	case $ans in
	    *)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Elixir/main.sh)
		;;
	esac
}

mainmenu