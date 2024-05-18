#!/bin/bash
echo
read -p "Вы уверены что хотите начать установку Oracle? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/initia/main.sh)
fi

# Clone repository
cd $HOME
rm -rf slinky
git clone https://github.com/skip-mev/slinky.git
cd slinky
git checkout v0.4.3

# Build binaries
make build

# Move binary to local bin
mv build/slinky /usr/local/bin/
rm -rf build

sudo tee /etc/systemd/system/slinky.service > /dev/null <<EOF
[Unit]
Description=Initia Slinky Oracle
After=network-online.target

[Service]
User=$USER
ExecStart=$(which slinky) --oracle-config-path $HOME/slinky/config/core/oracle.json --market-map-endpoint 127.0.0.1:17990
Restart=on-failure
RestartSec=30
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable slinky.service
sudo systemctl start slinky.service

read -p "Установка завершена для выхода в меню нажмите Enter"

source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Nodes/active/initia/main.sh)

