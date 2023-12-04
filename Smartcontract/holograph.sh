#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
	mainmenu() {
		echo "$(printBMagenta ' HOLOGRAPH')"
		echo "$(printBGreen ' 1 ')Deploying a Collection"
		echo "$(printBGreen ' 2 ')Minting an NFT"
		echo "$(printBGreen ' 3 ')Bridging an NFT"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
		read -r ans
			case $ans in
		#---------------------------------------#
			1)
			Deploying
			;;
		#---------------------------------------#
			2)
			Minting
			;;
		#---------------------------------------#
			3)
			Bridging
			;;
		#---------------------------------------#	
			4)
			source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menusmart.sh)
			;;
		#---------------------------------------#
			0)
			echo $(printBCyan '	"Bye bye."')
			exit
			;;
		#---------------------------------------#	
			*)
			clear && printlogo
			echo " $(printCyanBlink '                 =====================')"
			echo " $(printRed  '================')$(printCyanBlink ' = ')$(printBRed 'Неверный запрос! ')$(printCyanBlink ' = ')$(printRed  '================')"
			echo " $(printCyanBlink '                 =====================')"
			mainmenu
			;;
		#---------------------------------------#
			esac
}

Deploying(){
	clear && printlogo && printholograph && echo
  holograph create:contract
mainmenu
}

Minting(){
	clear && printlogo && printholograph
	echo
  holograph create:nft
	mainmenu
}

Bridging(){
  echo
  holograph bridge:nft
	mainmenu
}


back(){
  source <(curl -s https://raw.githubusercontent.com/dzhagerr/xl1/main/xscript/menu/menusmart.sh)
}

mainmenu