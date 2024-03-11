#!/bin/bash -e

echo -e "\e[1;35m
╔╦╗╔═╗╦╦╔═╔═╗
 ║ ╠═╣║╠╩╗║ ║
 ╩ ╩ ╩╩╩ ╩╚═╝\e[0m"

    echo " 1. Установить"
    echo " 2. Удалить"
    echo " ---------"
    echo "  0. Назад"
    echo " 10. Выход"
    echo " ---------"
    echo -ne "Ввод: "
    read -r ans

    case $ans in
        1) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/install.sh) ;;
        2) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/delete.sh) ;;
        0) source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_nodes.sh) ;;
        10) echo "Пока-пока." && exit ;;
        *) clear && echo "Неверный ввод!" && mainmenu ;;
    esac
}

mainmenu