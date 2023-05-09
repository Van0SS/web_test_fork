#!/bin/sh
# Stop on any error
set -e

# Load env variables
ROOT_DIR="$(git rev-parse --show-toplevel)"
source "$ROOT_DIR/deploy/local/local.env"

# Update the app, update scripts, run deploy
$SSH_COMMAND "cd $PROJECT_PATH/microk8s && git pull && ./deploy/setup/deploy-ingress.sh"
