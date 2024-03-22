#!/bin/bash -e
mainmenu() {
echo -e "\e[1;35m
╔╦╗╔═╗╦╦╔═╔═╗
 ║ ╠═╣║╠╩╗║ ║
 ╩ ╩ ╩╩╩ ╩╚═╝\e[0m"

    echo " 1. Управление"
    echo " 2. Установка"
    echo " 3. Обновление"
    echo " 4. Удаление"
    echo " ---------"
    echo "  0. Назад"
    echo " 10. Выход"
    echo " ---------"
    echo -ne "Ввод: "
    read -r ans

    case $ans in
        1) clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/control.sh) ;;
        2) clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/install.sh) ;;
        4) clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/delete.sh) ;;
        3) clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/update.sh) ;;
        0) clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_nodes.sh) ;;
        10) echo "До свидания." && exit ;;
        *) clear && echo "Неверный ввод!" && mainmenu ;;
    esac
}

mainmenu