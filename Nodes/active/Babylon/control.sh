#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
mainmenu() { 
		echo "$(printBYellow ' BABYLON')"
        echo "$(printBGreen ' 1 ')Управление токенами"
		echo "$(printBGreen ' 2 ')Кошелек"
		echo "$(printBGreen ' 3 ')Валидатор"
		echo "$(printBGreen ' 4 ')Голосование"
		echo "$(printBGreen ' 5 ')Обслуживание"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
#	Свойства меню
read -r ans
	case $ans in
        1)
        clear && printlogo && token
        ;;

		2)
        clear && printlogo && wallet
		;;

		3)
		clear && printlogo && validator
		;;

		4)
		clear && printlogo && governance
		;;

		5)
		clear && printlogo && setting
		;;

		0)
		source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Babylon/main.sh)
		;;

		10)
		echo $(printBCyan '	"Bye bye."') && exit
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
		;;
	esac
}

token(){
		echo "$(printBYellow ' BABYLON')"
        echo "$(printBGreen ' 1 ')Отправить токены на кошелек"
		echo "$(printBGreen ' 2 ')Снять вознаграждения со всех валидаторов"
		echo "$(printBGreen ' 3 ')Снять комиссионные и вознаграждения с вашего валидатора"
        echo "$(printBGreen ' 4 ')Делегируйте токены в X-l1bra"
		echo "$(printBGreen ' 5 ')Делегировать токены себе"
        echo "$(printBGreen ' 6 ')Делегировать токены другому валидатору"
		echo "$(printBGreen ' 7 ')Передать токенов другому валидатору"
        echo "$(printBGreen ' 8 ')Отвязать токены от вашего валидатора"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
    read -r ans
	    case $ans in
		1)
		clear && printlogo
        read -r -p "  Введите адрес кошелька:  " VAR1
        echo -ne "(printBRed ' 1bbn = 1000000ubbn')"
        read -r -p "  Введите количество монет ubbn:  " VAR2
		babylond tx bank send wallet "$VAR1" "$VAR2"ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        token
		;;

		2)
		clear && printlogo
		babylond tx distribution withdraw-all-rewards --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        token
		;;

		3)
		clear && printlogo
		babylond tx distribution withdraw-rewards $(babylond keys show wallet --bech val -a) --commission --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        token
		;;

		4)
		clear && printlogo
        echo -ne "(printBRed ' 1bbn = 1000000ubbn')"
        read -r -p "  Введите количество монет ubbn:  " VAR3
		babylond tx epoching redelegate $(babylond keys show wallet --bech val -a) <TO_VALOPER_ADDRESS> 1000000ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        token
		;;

        5)
		clear && printlogo
        echo -ne "(printBRed ' 1bbn = 1000000ubbn')"
        read -r -p "  Введите количество монет ubbn:  " VAR4
        babylond tx epoching delegate $(babylond keys show wallet --bech val -a) "$VAR4"ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        token
        ;;

        6)
		clear && printlogo
        read -r -p "  Введите адрес валидатора:  " VAR5
        echo -ne "(printBRed ' 1bbn = 1000000ubbn')"
        read -r -p "  Введите количество монет ubbn:  " VAR6
        babylond tx epoching delegate "$VAR5" "$VAR6"ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        token
        ;;

        7)
		clear && printlogo
        read -r -p "  Введите адрес валидатора:  " VAR6
        echo -ne "(printBRed ' 1bbn = 1000000ubbn')"
        read -r -p "  Введите количество монет ubbn:  " VAR7
        babylond tx epoching redelegate $(babylond keys show wallet --bech val -a) "$VAR6" "$VAR7"ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        token
        ;;

        8)
		clear && printlogo
        echo -ne "(printBRed ' 1bbn = 1000000ubbn')"
        read -r -p "  Введите количество монет ubbn:  " VAR8
        babylond tx epoching unbond $(babylond keys show wallet --bech val -a) "$VAR8"ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        token
        ;;

		0)
		clear && printlogo && mainmenu
		;;

		10)
		echo $(printBCyan '	"Bye bye."') && exit
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && wallet
		;;
	    esac
}

wallet(){
		echo "$(printBYellow ' BABYLON')"
		echo "$(printBGreen ' 1 ')Проверить баланс"
		echo "$(printBGreen ' 2 ')Просмотреть список кошельков"
		echo "$(printBGreen ' 3 ')Создать кошелек"
		echo "$(printBGreen ' 4 ')Востановить кошелек"
        echo "$(printBGreen ' 5 ')Создать BLS подпись"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
    read -r ans
	    case $ans in
		1)
		clear && printlogo
		babylond q bank balances $(babylond keys show wallet -a) && wallet
		;;

		2)
		clear && printlogo
		babylond keys list && wallet
		;;

		3)
		clear && printlogo
		babylond keys add wallet && wallet
		;;

		4)
		clear && printlogo
		babylond keys add wallet --recover && wallet
		;;

        5)
		clear && printlogo
        babylond create-bls-key $(babylond keys show wallet -a) && wallet
        ;;

		0)
		clear && printlogo && mainmenu
		;;

		10)
		echo $(printBCyan '	"Bye bye."') && exit
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && wallet
		;;
	    esac
}

validator(){
		echo "$(printBYellow ' BABYLON')"
		echo "$(printBGreen ' 1 ')Информация о валидаторе"
		echo "$(printBGreen ' 2 ')Создать валидатор"
        echo "$(printBGreen ' 3 ')Выйти из тюрьмы"
		echo "$(printBGreen ' 4 ')Причина тюремного заключения"
		echo "$(printBGreen ' 5 ')Список всех активных валидаторов"
        echo "$(printBGreen ' 6 ')Список всех неактивных валидаторов"
        echo "$(printBGreen ' 7 ')Проверить правильность ключа валидатора"
        echo "$(printBGreen ' 8 ')Создать резервную копию ключа валидатора"
        echo "$(printBGreen ' 9 ')Востановить валидатор"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
    read -r ans
	    case $ans in
		1)
		clear && printlogo
		babylond q staking validator $(babylond keys show wallet --bech val -a) && validator
		;;

		2)
		clear && printlogo
        read -r -p "  Введите имя валидатора:  " VAR1
        babylond tx checkpointing create-validator --amount 1000000ubbn --pubkey $(babylond tendermint show-validator) --moniker"$VAR1" --chain-id bbn-test-2 --commission-rate 0.05 --commission-max-rate 0.20 --commission-max-change-rate 0.01 --min-self-delegation 1 --from wallet --gas-adjustment 1.4 --gas auto --fees 10ubbn
		validator
        ;;

		3)
		clear && printlogo
		babylond tx slashing unjail --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y && validator
		;;

        4)
		clear && printlogo
        babylond query slashing signing-info $(babylond tendermint show-validator) && validator
        ;;

        5)
		clear && printlogo
        babylond q staking validators -oj --limit=3000 | jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) + " \t " + .description.moniker' | sort -gr | nl && validator
        ;;

        6)
		clear && printlogo
        babylond q staking validators -oj --limit=3000 | jq '.validators[] | select(.status=="BOND_STATUS_UNBONDED")' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) + " \t " + .description.moniker' | sort -gr | nl && validator
        ;;

        7)
		clear && printlogo
        [[ $(babylond q staking validator $(babylond keys show wallet --bech val -a) -oj | jq -r .consensus_pubkey.key) = $(babylond status | jq -r .ValidatorInfo.PubKey.value) ]] && echo -e "\n\e[1m\e[32mTrue\e[0m\n" || echo -e "\n\e[1m\e[31mFalse\e[0m\n"
        validator
        ;;

        8)
		clear && printlogo
        sudo systemctl stop babylon.service
        mkdir $HOME/babylon_backup_validator_key
        cp $HOME/.babylond/data/priv_validator_state.json $HOME/babylon_backup_validator_key/Snapshots/priv_validator_state.json.backup
        sudo systemctl start babylon.service
        validator
        ;;

        9)
		clear && printlogo
        sudo systemctl stop babylon.service
        cp $HOME/babylon_backup_validator_key/priv_validator_state.json.backup $HOME/.babylond/data/priv_validator_state.json
        sudo systemctl start babylon.service
        validator
        ;;

		0)
		clear && printlogo && mainmenu
		;;

		10)
		echo $(printBCyan '	"Bye bye."') && exit
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && wallet
		;;
	    esac
}

governance(){
        echo "$(printBYellow ' BABYLON')"
		echo "$(printBGreen ' 1 ')Перечислить все голосования"
		echo "$(printBGreen ' 2 ')Просмотреть голосование по id"
        echo "$(printBGreen ' 3 ')Проголосовать "Yes""
		echo "$(printBGreen ' 4 ')Проголосовать "No""
		echo "$(printBGreen ' 5 ')Голосовать "Abstain""
        echo "$(printBGreen ' 6 ')Проголосовать за "NoWithVeto""
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
    read -r ans
	    case $ans in
		1)
		clear && printlogo
		babylond query gov proposals && governance
		;;

		2)
		clear && printlogo
        read -r -p "  Введите id голосования:  " VAR9
        babylond query gov proposal "$VAR9"
		governance
        ;;

		3)
		clear && printlogo
        read -r -p "  Введите id голосования:  " VAR10
		babylond tx gov vote "$VAR10" yes --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        governance
		;;

        4)
		clear && printlogo
        read -r -p "  Введите id голосования:  " VAR11
        babylond tx gov vote "$VAR11" no --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        governance
        ;;

        5)
		clear && printlogo
        read -r -p "  Введите id голосования:  " VAR12
        babylond tx gov vote "$VAR12" abstain --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        governance
        ;;

        6)
		clear && printlogo
        read -r -p "  Введите id голосования:  " VAR13
        babylond tx gov vote "$VAR13" NoWithVeto --from wallet --chain-id bbn-test-2 --gas-adjustment 1.4 --gas auto --fees 10ubbn -y
        governance
        ;;

		0)
		clear && printlogo && mainmenu
		;;

		10)
		echo $(printBCyan '	"Bye bye."') && exit
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && wallet
		;;
	    esac

}

setting(){
      echo "$(printBYellow ' BABYLON')"
		echo "$(printBGreen ' 1 ')Изменить порт"
		echo "$(printBGreen ' 2 ')Получить информацию о синхронизации"
        echo "$(printBGreen ' 3 ')Установить минимальную цену на газ"
        echo "$(printBGreen ' 4 ')Запустить ноду"
        echo "$(printBGreen ' 5 ')Остановить ноду"
        echo "$(printBGreen ' 6 ')Перезапустить ноду"
        echo "$(printBGreen ' 7 ')Просмотреть статус ноды"
        echo "$(printBGreen ' 8 ')Просмотреть журнал обслуживания ноды"
        echo "$(printBGreen ' 9 ')Очистить кэш"
		echo ' ---------'
		echo "$(printBBlue '  0 ')Назад"
		echo "$(printBRed ' 10 ')Выход"
		echo ' ---------'
		echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
    read -r ans
	    case $ans in
		1)
		clear && printlogo
        read -r -p "  Введите порт для смены:  " VAR14
		CUSTOM_PORT="$VAR14"
        sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${CUSTOM_PORT}58\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${CUSTOM_PORT}57\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${CUSTOM_PORT}60\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${CUSTOM_PORT}56\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${CUSTOM_PORT}66\"%" $HOME/.babylond/config/config.toml
        sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${CUSTOM_PORT}17\"%; s%^address = \":8080\"%address = \":${CUSTOM_PORT}80\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${CUSTOM_PORT}90\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${CUSTOM_PORT}91\"%" $HOME/.babylond/config/app.toml
        sudo systemctl restart babylon.service
        setting
		;;

		2)
		clear && printlogo
        babylond status 2>&1 | jq .SyncInfo
		setting
        ;;

		3)
		clear && printlogo
        echo "По умолчанию газ = $(printBGreen '0.00001')"
        read -r -p "  Введите желаемый газ:  " VAR15
		sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \""$VAR15"ubbn\"/" $HOME/.babylond/config/app.toml
        sudo systemctl restart babylon.service
        setting
		;;

        4)
		clear && printlogo
        sudo systemctl start babylon.service
        setting
        ;;

        5)
		clear && printlogo
        sudo systemctl stop babylon.service
        setting
        ;;

        6)
		clear && printlogo
        sudo systemctl restart babylon.service
        setting
        ;;

        7)
		clear && printlogo
        sudo systemctl status babylon.service
        setting
        ;;

        8)
		clear && printlogo
        sudo journalctl -u babylon.service -f --no-hostname -o cat
        setting
        ;;

        9)
		clear && printlogo
        sudo systemctl stop babylon.service
        mkdir babylon_backup_validator_key
        mkdir babylon_backup_validator_key/Snapshots
        cp $HOME/.babylond/data/priv_validator_state.json $HOME/babylon_backup_validator_key/Snapshots/priv_validator_state.json.backup
        curl -L https://snapshots.kjnodes.com/babylon-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.babylond
        mv $HOME/babylon_backup_validator_key/Snapshots/priv_validator_state.json.backup $HOME/.babylond/data/priv_validator_state.json
        sudo systemctl start babylon.service
        echo "$(printBGreen ' Готово ')"
        setting
        ;;

		0)
		clear && printlogo && mainmenu
		;;

		10)
		echo $(printBCyan '	"Bye bye."') && exit
		;;

		*)
		clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && wallet
		;;
	    esac
}

mainmenu