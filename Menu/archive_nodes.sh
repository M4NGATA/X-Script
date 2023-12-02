#!/bin/bash
# Подгрузка общих функций и цвета
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
# Шапка скрипта

# Основное меню
    mainmenu(){
		echo "$(printBMagenta ' АРХИВ НОД')"
        echo "$(printBGreen ' 1 ')Nibiru"
        echo "$(printBGreen ' 2 ')Starknet"
        echo "$(printBGreen ' 3 ')Fleek"
        echo "$(printBGreen ' 4 ')Celestia"
        echo "$(printBGreen ' 5 ')Quasar"
        echo "$(printBGreen ' 6 ')SUI"
		echo "$(printBGreen ' 7 ')DeFund"
		echo ' --------'
		echo "$(printBRed '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' --------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ':')"
	read -r ans
		case $ans in
            1)
            source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/nibiru/main.sh)
            ;;

            2)
            source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/starknet/main.sh)
            ;;

            3)
            source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/active/Fleek/main.sh)
            ;;

			4)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/celestia/main.sh)
			;;

			5)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/quasar/main.sh)
			;;

			6)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/sui/main.sh)
			;;

			7)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/nodes/archive/defund/main.sh)
			;;

			0)
			source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Menu/menu_nodes.sh)
			;;

            10)
            echo $(printBCyan '"Bye bye."') && exit
            ;;

			*)
			clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
			;;
		esac
		}
#-----------------------------------------------------------------------------------#
mainmenu