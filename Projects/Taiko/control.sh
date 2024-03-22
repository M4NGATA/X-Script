#!/bin/bash -e

taiko_menu() {
echo -e "\e[1;35m
╔╦╗╔═╗╦╦╔═╔═╗
 ║ ╠═╣║╠╩╗║ ║
 ╩ ╩ ╩╩╩ ╩╚═╝\e[0m"

    echo " 1. Запустить ноду"
    echo " 2. Остановить ноду"
    echo " 3. Перезапустить ноду"
    echo " 4. Посмотреть все логи"
    echo " 5. Посмотреть логи выполнения"
    echo " 6. Посмотреть логи клиентского драйвера"
    echo " 7. Посмотреть логи proposer"
    echo " 8. Посмотреть статистику использования системных ресурсов"
    echo " ---------"
    echo "  0. Назад"
    echo " 10. Выход"
    echo " ---------"
    echo -ne "Ввод: "
    read -r ans

    case $ans in
        1) docker compose -f simple-taiko-node/docker-compose.yml up -d ;;
        2) docker compose -f simple-taiko-node/docker-compose.yml down ;;
        3) docker compose -f simple-taiko-node/docker-compose.yml down && docker compose -f simple-taiko-node/docker-compose.yml up -d ;;
        4) docker compose -f simple-taiko-node/docker-compose.yml logs -f --tail=2000 ;;
        5) docker compose -f simple-taiko-node/docker-compose.yml logs -f l2_execution_engine --tail=2000 ;;
        6) docker compose -f simple-taiko-node/docker-compose.yml logs -f taiko_client_driver --tail=2000 ;;
        7) docker compose -f simple-taiko-node/docker-compose.yml logs -f taiko_client_proposer --tail=2000 ;;
        8) docker stats ;;
        0) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/main.sh) ;;
        10) echo "Bye bye." && exit ;;
        *) clear && echo "Invalid input!" && taiko_menu ;;
    esac
}


taiko_menu