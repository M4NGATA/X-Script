#!/bin/bash

# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo


# Проверка наличия установленного пакета btop через snap
	if ! snap list | grep -q btop; then
		echo "Установка пакета btop..."
		sudo apt install snapd -y && snap install btop
		echo "Пакет btop установлен."
fi

# Запуск btop
echo "Запуск btop..."
snap run btop

source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/homemenu.sh)
source <(curl -s https://raw.githubusercontent.com/M4NGATA/C-Script/main/