#!/bin/bash

clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo

mainmenu() {
    echo "$(printBCyan ' ZORA')"
    echo "$(printGreen  '-----------------------------------------')"
    echo "$(printYellow 'Рекомендуемые требования к оборудованию.')"
    echo "$(printBCyan '	  8CPU 16RAM 200GB')"
    echo "$(printGreen  '-----------------------------------------')"
    echo "$(printCyan    'Вы действительно хотите начать установку') $(printCyanBlink '???')"
    echo "$(printGreen    ' 1) Да')"
    echo "$(printRed    ' 2) Нет')"
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

no() {
    source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Zora/main.sh)
}

yes() {
    clear && printlogo && echo

    echo "$(printBYellow ' Обновление пакетов и установка необходимых зависимостей')"
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt install curl build-essential git screen jq pkg-config libssl-dev libclang-dev ca-certificates gnupg lsb-release -y

    # Проверка и установка Docker, если не установлен
    if ! command -v docker &> /dev/null; then
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
            $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
            sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y
    fi

    # Клонирование репозитория и настройка Conduit
    git clone https://github.com/conduitxyz/node.git
    cd node
    ./download-config.py zora-mainnet-0
    export CONDUIT_NETWORK=zora-mainnet-0
    cp .env.example .env

    # Ввод URL OP_NODE_L1_ETH_RPC
    echo "Введите URL OP_NODE_L1_ETH_RPC:"
    read -r new_value
    sed -i "s|OP_NODE_L1_ETH_RPC=.*|OP_NODE_L1_ETH_RPC=$new_value|g" .env

    # Запуск Docker Compose
    if docker-compose up --build -d; then
        docker ps
		cd
        subnmenu
    else
        echo "$(printBRed 'Ошибка при запуске Docker Compose!')"
    fi
}

subnmenu() {
    echo -ne "$(printCyan 'Установка завершена') $(printCyanBlink '!!!')"
    echo -ne "$(printCyan 'Нажмите Enter:') "
    read -r ans

    case $ans in
        *)
           	source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Zora/main.sh)
            ;;
    esac
}

mainmenu
