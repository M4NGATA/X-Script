#!/bin/bash

# Check and install dialog if not installed
if ! which dialog > /dev/null; then
    echo "Installing dialog..."
    sudo apt-get install -y dialog
fi

# Create a menu using dialog in a loop
while true; do
    cmd=(dialog --keep-tite --menu "Select options:" 22 76 16)
    options=(1 "Install Taiko Katla Node"
             2 "Install Hekla aNode"
             3 "View Logs Katla Node"
             4 "View link Graphana"
             5 "Exit")
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    case $choices in
        1)
            # Install Taiko Katla Node:
            echo "Installing Taiko Katla Node..."
            sudo apt update && sudo apt upgrade -y
            sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
            sudo apt-get update
            sudo apt-get install -y docker-ce
            sudo curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
            sudo apt install -y git
            sudo apt remove -y ansible
            sudo apt-get install -y software-properties-common
            sudo apt-add-repository --yes --update ppa:ansible/ansible
            sudo apt install -y ansible
            cd /root/simple-taiko-node
            docker-compose down
            docker volume rm simple-taiko-node_l2_execution_engine_data
            docker volume rm simple-taiko-node_zkevm_chain_prover_rpcd_data
            docker volume rm simple-taiko-node_prometheus_data
            docker volume rm simple-taiko-node_grafana_data
            docker rmi gcr.io/evmchain/taiko-geth:katla gcr.io/evmchain/taiko-client:katla gcr.io/evmchain/katla-proverd:latest prom/prometheus:latest grafana/grafana:latest
            docker system prune -a
            cd $HOME
            git clone https://github.com/nodemasterpro/deploy-node-taiko.git
            cd deploy-node-taiko
            ansible-playbook install_holesky_node.yml
            su - ethuser -c 'cd eth-docker && ./ethd up'
            ;;
        2)
            # Install Hekla aNode:
            echo "Installing Hekla aNode..."
            cd deploy-node-taiko && ansible-playbook install_taiko_node.yml && sudo systemctl start taiko-node && cd
            ;;
        3)
            # View Logs Katla Node:
            echo "Viewing logs..."
            su - ethuser -c 'cd eth-docker && ./ethd logs -f'
            ;;
        4)
            # View link Graphana:
            echo "View link Graphana..."
            ip=$(curl https://ipinfo.io/ip)
            graphana_link="http://$ip:3001/d/L2ExecutionEngine/l2-execution-engine-overview"
            dialog --title "Graphana Link" --msgbox "$graphana_link" 10 70
            ;;
        5)
            # Exit
            break
            ;;
    esac
done

