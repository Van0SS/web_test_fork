#!/bin/sh
# Stop on any error
set -e

BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'

color() {
    APP=$1
    CMD=$2
    printf "${CYAN}$APP${NC}: ${BLUE}$CMD${NC}\n"
}

green() {
    printf "${GREEN}$@${NC}\n"
}

# Docker https://docs.docker.com/engine/install/ubuntu/
APP_NAME='docker'
if ! command -v $APP_NAME &> /dev/null
then
    green "-- Installing '$APP_NAME'"

    color $APP_NAME 'sudo apt-get update'
    sudo apt-get update

    color $APP_NAME 'sudo apt-get install -y ca-certificates curl gnupg'
    sudo apt-get install -y ca-certificates curl gnupg

    color $APP_NAME 'sudo install -m 0755 -d /etc/apt/keyrings'
    sudo install -m 0755 -d /etc/apt/keyrings

    color $APP_NAME 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg'
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    color $APP_NAME 'sudo chmod a+r /etc/apt/keyrings/docker.gpg'
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    color $APP_NAME 'echo deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'
    echo \
      "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    color $APP_NAME 'sudo apt update'
    sudo apt update

    color $APP_NAME 'sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin'
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    color $APP_NAME 'sudo groupadd docker'
    sudo groupadd docker

    color $APP_NAME 'sudo usermod -aG docker $USER'
    sudo usermod -aG docker $USER

    color $APP_NAME 'newgrp docker'
    newgrp docker
else
    green "-- '$APP_NAME' already installed, skipping"
fi

# K8S https://microk8s.io/docs/getting-started
APP_NAME='microk8s'
if ! command -v $APP_NAME &> /dev/null
then
    green "-- Installing '$APP_NAME'"

    color $APP_NAME 'sudo apt-get update'
    sudo apt-get update

    color $APP_NAME 'sudo snap install microk8s --classic --channel=1.27'
    sudo snap install microk8s --classic --channel=1.27

    color $APP_NAME 'sudo usermod -a -G microk8s $USER'
    sudo usermod -a -G microk8s $USER

    color $APP_NAME 'sudo chown -f -R $USER ~/.kube'
    sudo chown -f -R $USER ~/.kube
else
    green "-- '$APP_NAME' already installed, skipping"
fi


# Helm https://helm.sh/docs/intro/install/#from-apt-debianubuntu
APP_NAME='helm'
if ! command -v $APP_NAME &> /dev/null
then
    green "-- Installing '$APP_NAME'"

    color $APP_NAME 'sudo apt-get update'
    sudo apt-get update

    color $APP_NAME 'curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null'
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null

    color $APP_NAME 'sudo apt-get install apt-transport-https --yes'
    sudo apt-get install apt-transport-https --yes

    color $APP_NAME 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list'
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

    color $APP_NAME 'sudo apt-get update'
    sudo apt-get update

    color $APP_NAME 'sudo apt-get install helm'
    sudo apt-get install helm
else
    green "-- '$APP_NAME' already installed, skipping"
fi
