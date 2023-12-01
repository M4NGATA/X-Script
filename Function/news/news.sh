#!/bin/bash

# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo

# Шапка скрипта
	echo "$(printBMagenta ' ОБНОВЛЕНИЯ    ')"

#-----------------------------Лента новостей-----------------------------------------#
	echo " $(printBMagenta '=')""$(printBYellow '| 25.10.2023 |') Добавлена установка ноды Fleek"
	echo " $(printBMagenta '=')""$(printBYellow '| 12.10.2023 |') Holograph добавлен смартконтракт"
	echo " $(printBMagenta '=')""$(printBYellow '| 05.10.2023 |') Holograph добавлен функционал в меню"
	echo " $(printBMagenta '=')""$(printBYellow '| 04.10.2023 |') Holograph исправлен баг в установке ноды "
	echo " $(printBMagenta '=')""$(printBYellow '| 03.10.2023 |') Оыбновление NIBIRU  v0.21.11 "
	echo " $(printBMagenta '=')""$(printBYellow '| 28.09.2023 |') Обновление STARKNET pathfinder v0.8.2. "
	echo " $(printBMagenta '=')""$(printBYellow '| 20.09.2023 |') Обновление сети NIBIRU v0.21.9 "
	echo " $(printBMagenta '=')""$(printBYellow '| 31.08.2023 |') Добавлена новая нода Holograph "
	echo " $(printBMagenta '=')""$(printBYellow '| 13.07.2023 |') Shardeum update Sphinx Validator 1.5.2 "
	echo " $(printBMagenta '=')""$(printBYellow '| 03.07.2023 |') Shardeum update Sphinx Validator 1.5.1 "
	echo " $(printBMagenta '=')""$(printBYellow '| 29.06.2023 |') Starknet update validator v6.3."
	echo " $(printBMagenta '=')""$(printBYellow '| 22.06.2023 |') Shardeum! Добавлен автоматический запуск валидатора."
	echo " $(printBMagenta '=')""$(printBYellow '| 19.06.2023 |') Добавлен смартконтракт zkSync в раздел смартконтрактов."
	echo " $(printBMagenta '=')""$(printBYellow '| 16.06.2023 |') Добален просмотр IP сервера в основном меню."
	echo " $(printBMagenta '=')""$(printBYellow '| 14.06.2023 |') Переделано основное меню, добавлены смартконтракты"
	echo " $(printBMagenta '=')""$(printBYellow '| 12.06.2023 |') Добалена установка и запуск прокси на сервере"
	echo " $(printBMagenta '=')""$(printBYellow '| 11.06.2023 |') Добавлен системный монитор"
	echo ' --------'
	echo "$(printBBlue '  0 ')Назад"
	echo "$(printBRed ' 10 ')Выход"
	echo ' --------'
	echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
	#-------------------------Свойства меню-------------------------#
		read -r ans
			case $ans in

			0)

			;;

			10)
			echo $(printBCyan '"Bye bye."')
			exit
			;;

			*)
			clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
			;;

		esac
		}

mainmenu