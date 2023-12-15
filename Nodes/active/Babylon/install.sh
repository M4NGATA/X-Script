#!/bin/bash
	clear && source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Common/theme.sh) && printlogo
    mainmenu() {
		echo "$(printBYellow ' BABYLON')"
		echo "$(printYellow 'Минимальные требования к оборудованию.')"
		echo "$(printBCyan '	4CPU 8RAM 200GB')"
		echo "$(printGreen  '-----------------------------------------')"
	    echo "$(printCyan	'Вы действительно хотите начать установку') $(printCyanBlink '???')"
        echo ' -------'
	    echo "$(printGreen	'  1 Да')"
	    echo "$(printRed	'  2 Нет')"
		echo ' -------'
        echo -ne "$(printBGreen ' Ввод')$(printGreenBlink ': ')"
                read -r ans
	            case $ans in
		        1)
		        yes
		        ;;
		        2)
		        no
		        ;;
		        *)
		        clear && printlogo && echo "$(printBRed ' Неверный запрос!')" && mainmenu
        	    ;;
                esac
    }


no(){
    source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/Babylon/main.sh)
}

yes(){
#Setup validator name
    read -r -p " $(printBGreen 'Укажите имя валидатора:') " MONIKER

#Install dependencies
echo "$(printBYellow ' Install dependencies')"
    sudo apt -q update && sudo apt -qy upgrade && sudo apt -qy install curl git jq lz4 build-essential

#Install Go 
    echo "$(printBYellow ' Install Go')"
        sudo rm -rf /usr/local/go
        curl -Ls https://go.dev/dl/go1.20.12.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
        eval $(echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/golang.sh)
        eval $(echo 'export PATH=$PATH:$HOME/go/bin' | tee -a $HOME/.profile)


#Download and build binaries 
echo "$(printBGreen ' Download and build binaries...')"
# Clone project repository
    echo "$(printBYellow ' Clone project repository')"
        cd $HOME
        rm -rf babylon
        git clone https://github.com/babylonchain/babylon.git
        cd babylon
        git checkout v0.7.2

# Build binaries
    echo "$(printBYellow ' Build binaries')"
        make build

# Prepare binaries for Cosmovisor
    echo "$(printBYellow ' Prepare binaries for Cosmovisor')"
        mkdir -p $HOME/.babylond/cosmovisor/genesis/bin
        mv build/babylond $HOME/.babylond/cosmovisor/genesis/bin/
        rm -rf build

# Create application symlinks
    echo "$(printBYellow ' Create application symlinks')"
        sudo ln -s $HOME/.babylond/cosmovisor/genesis $HOME/.babylond/cosmovisor/current -f
        sudo ln -s $HOME/.babylond/cosmovisor/current/bin/babylond /usr/local/bin/babylond -f


#Install Cosmovisor and create a service 
    echo "$(printBGreen ' Install Cosmovisor and create a service...')"
# Download and install Cosmovisor
    echo "$(printBYellow ' Download and install Cosmovisor')"
        go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0

# Create service
    echo "$(printBYellow ' Create service')"
sudo tee /etc/systemd/system/babylon.service > /dev/null << EOF
[Unit]
Description=babylon node service
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/.babylond"
Environment="DAEMON_NAME=babylond"
Environment="UNSAFE_SKIP_BACKUP=true"
Environment="PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.babylond/cosmovisor/current/bin"

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl daemon-reload
    sudo systemctl enable babylon.service


#Initialize the node 
    echo "$(printBGreen ' Initialize the node... ')"

# Set node configuration
    echo "$(printBYellow ' Set node configuration')"
        babylond config chain-id bbn-test-2
        babylond config keyring-backend test
        babylond config node tcp://localhost:16457

# Initialize the node
    echo "$(printBYellow ' Initialize the node')"
        babylond init $MONIKER --chain-id bbn-test-2

# Download genesis and addrbook
echo "$(printBYellow ' Download genesis and addrbook')"
    curl -Ls https://snapshots.kjnodes.com/babylon-testnet/genesis.json > $HOME/.babylond/config/genesis.json
    curl -Ls https://snapshots.kjnodes.com/babylon-testnet/addrbook.json > $HOME/.babylond/config/addrbook.json

# Add seeds
echo "$(printBYellow ' Add seeds')"
    sed -i -e "s|^seeds *=.*|seeds = \"3f472746f46493309650e5a033076689996c8881@babylon-testnet.rpc.kjnodes.com:16459\"|" $HOME/.babylond/config/config.toml

# Set minimum gas price
echo "$(printBYellow ' Set minimum gas price')"
    sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.00001ubbn\"|" $HOME/.babylond/config/app.toml

# Set pruning
echo "$(printBYellow ' Set pruning')"
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.babylond/config/app.toml

# Set custom ports
echo "$(printBYellow ' Set custom ports')"
    sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:16458\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:16457\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:16460\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:16456\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":16466\"%" $HOME/.babylond/config/config.toml
    sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://0.0.0.0:16417\"%; s%^address = \":8080\"%address = \":16480\"%; s%^address = \"localhost:9090\"%address = \"0.0.0.0:16490\"%; s%^address = \"localhost:9091\"%address = \"0.0.0.0:16491\"%; s%:8545%:16445%; s%:8546%:16446%; s%:6065%:16465%" $HOME/.babylond/config/app.toml

#Download latest chain snapshot 
echo "$(printBYellow ' Download latest chain snapshot')"
curl -L https://snapshots.kjnodes.com/babylon-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.babylond
[[ -f $HOME/.babylond/data/upgrade-info.json ]] && cp $HOME/.babylond/data/upgrade-info.json $HOME/.babylond/cosmovisor/genesis/upgrade-info.json

#Start service and check the logs 
sudo systemctl start babylon.service 









}



mainmenu