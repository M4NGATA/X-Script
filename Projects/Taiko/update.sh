#!/bin/bash -e

echo -e "\e[1;35m
╔╦╗╔═╗╦╦╔═╔═╗
 ║ ╠═╣║╠╩╗║ ║
 ╩ ╩ ╩╩╩ ╩╚═╝\e[0m"
 
read -p "Продолжить обновление? (y/n): " answer
if [[ $answer != "y" && $answer != "Y" ]]; then
    echo "Обновление отменено."
    clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/main.sh)
    exit 1
fi

cd simple-taiko-node || exit 1
git pull origin main && docker compose pull
docker compose down && docker compose up -d
cd - || exit

echo -e "\e[1;32m\nОбновление завершено. Для продолжения нажмите Enter.\e[0m"
read -p "Нажмите Enter, чтобы продолжить..."
source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/main.sh)
