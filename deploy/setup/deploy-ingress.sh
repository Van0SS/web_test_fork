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

ENV="dev"
ROOT_DIR="$(git rev-parse --show-toplevel)"
INGRESS_HELM_PATH="$ROOT_DIR/deploy/helm/ingress"

ING_CMD="helm upgrade ingress $INGRESS_HELM_PATH/ --values $INGRESS_HELM_PATH/values/$ENV.yaml --install"
color $ING_CMD
$ING_CMD

CERT_MANAGER_HELM_PATH="$ROOT_DIR/deploy/helm/cert-manager"
CERT_CMD="helm upgrade cert-manager $CERT_MANAGER_HELM_PATH/ --values $CERT_MANAGER_HELM_PATH/values/$ENV.yaml --install"
color $CERT_CMD
$CERT_CMD