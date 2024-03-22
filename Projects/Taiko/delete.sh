#!/bin/bash -e

echo -e "\e[1;35m
╔╦╗╔═╗╦╦╔═╔═╗
 ║ ╠═╣║╠╩╗║ ║
 ╩ ╩ ╩╩╩ ╩╚═╝\e[0m"

 read -p $'\e[1;31mХотите продолжить удаление узла Taiko? [Y/n]: \e[0m' choice
choice="${choice:-y}"
    if [[ $choice =~ ^[Yy]$ ]]; then
        echo "Начинаем удаление узла Taiko..."
    else
        echo "Удаление отменено."
        source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/main.sh)
        exit 1
    fi

    cd simple-taiko-node  || exit 1
    docker compose down -v
    cd - || exit

    echo -e "\e[1;32mУдаление узла Taiko завершено.\e[0m Нажмите Enter, чтобы продолжить..."
    read
    source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/main.sh)



