#!/bin/sh
# Stop on any error
set -e

BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'

color() {
    APP="k8s config"
    CMD=$1
    printf "${CYAN}$APP${NC}: ${BLUE}$CMD${NC}\n"
}


color 'microk8s status --wait-ready'
microk8s status --wait-ready

color 'microk8s start'
microk8s start

color 'microk8s enable registry'
microk8s enable registry

color 'microk8s enable hostpath-storage'
microk8s enable hostpath-storage

color 'microk8s ingress'
microk8s enable ingress

color "echo alias kubectl=microk8s kubectl' >> ~/.bash_aliases"
echo "alias kubectl='microk8s kubectl'" >> ~/.bash_aliases

color 'source ~/.bashrc'
source ~/.bashrc

# HELM
color 'microk8s.kubectl config view --raw > ~/.kube/config'
microk8s.kubectl config view --raw > ~/.kube/config


ENV="dev"
ROOT_DIR="$(git rev-parse --show-toplevel)"
INGRESS_HELM_PATH="$ROOT_DIR/deploy/helm/ingress"

HELM_CMD="helm upgrade ingress $INGRESS_HELM_PATH/ --values $INGRESS_HELM_PATH/values/$ENV.yaml --install"
color $HELM_CMD
$HELM_CMD

REGISTRY_CREATION_TIMEOUT_SECONDS=30
color "sleep $REGISTRY_CREATION_TIMEOUT_SECONDS Waiting for k8s Registry to be ready"
sleep $REGISTRY_CREATION_TIMEOUT_SECONDS

REPOSITORY_URL="localhost:32000"  # This is trusted storage prefix to support local repository in microk8s
color "curl $REPOSITORY_URL -v to test that's up and runni"
curl $REPOSITORY_URL -v
