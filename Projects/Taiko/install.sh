#!/bin/bash -e

echo -e "\e[1;35m
╔╦╗╔═╗╦╦╔═╔═╗
 ║ ╠═╣║╠╩╗║ ║
 ╩ ╩ ╩╩╩ ╩╚═╝\e[0m"

echo -e "\nДля продолжения установки узла \e[1;35mTaiko\e[0m, рекомендуемые ресурсы:"
echo -e "\e[1;32mРекомендуется: 4 CPU, 16 GB RAM, 1 TB SDD\e[0m"
echo -e "\e[1;31mМинимум: 4 CPU, 8 GB RAM, 1 TB SDD\e[0m"

read -p "Хотите продолжить установку узла Taiko? [Y/n]: " choice
choice="${choice:-y}"
    if [[ $choice =~ ^[Yy]$ ]]; then
        echo "Начинаем установку узла Taiko..."
    else
        echo "Установка прервана."
        source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/main.sh)
        exit 1
    fi

# Ask for L1_ENDPOINT_HTTP and L1_ENDPOINT_WS values
    read -p $'\e[1;33mВведите L1_ENDPOINT_HTTP: \e[0m' l1_endpoint_http
    read -p $'\e[1;33mВведите L1_ENDPOINT_WS: \e[0m' l1_endpoint_ws
    read -p $'\e[1;33mВведите L1_PROPOSER_PRIVATE_KEY: \e[0m' L1_PROPOSER_PRIVATE_KEY

# Install dependencies
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common git

# Install Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

# Add current user to Docker group
    sudo usermod -aG docker $USER

# Clone Taiko node repository
    git clone https://github.com/taikoxyz/simple-taiko-node.git
    cd simple-taiko-node

# Configure Taiko node
    cp .env.sample .env

# Update .env file with provided values
    sed -i "s|L1_ENDPOINT_HTTP=|L1_ENDPOINT_HTTP=$l1_endpoint_http|" .env
    sed -i "s|L1_ENDPOINT_WS=|L1_ENDPOINT_WS=$l1_endpoint_ws|" .env
    sed -i "s|L1_PROPOSER_PRIVATE_KEY=|L1_PROPOSER_PRIVATE_KEY=$L1_PROPOSER_PRIVATE_KEY|" .env
    sed -i "s|BLOCK_PROPOSAL_FEE=1|BLOCK_PROPOSAL_FEE=30|" .env
    sed -i "s|PROVER_ENDPOINTS=http://taiko_client_prover_relayer:9876|PROVER_ENDPOINTS=http://taiko-a6-prover.zkpool.io:9876|" .env
    sed -i "s|ENABLE_PROPOSER=false|ENABLE_PROPOSER=true|" .env

# Start Taiko node using docker-compose
    echo -e "\nStarting Taiko node..."
    docker compose up -d

# Get the current IP address
    ip=$(curl -s https://ipinfo.io/ip)

# install complete
# Print completion message in green color
    echo -e "\n\e[1;32mУстановка узла Taiko успешно завершена!\e[0m"
    echo -e "\nПанель управления узлом Taiko доступна по адресу:"
    echo -e "http://$ip:3001/d/L2ExecutionEngine/l2-execution-engine-overview?orgId=1&refresh=10s"
    read -p "Нажмите Enter, чтобы продолжить..."
    source <(curl -s https://raw.githubusercontent.com/M4NGATA/X-Script/main/Projects/Taiko/main.sh)

