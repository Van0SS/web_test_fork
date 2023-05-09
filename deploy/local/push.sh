#!/bin/sh
# Stop on any error
set -e

# Load env variables
ROOT_DIR="$(git rev-parse --show-toplevel)"
source "$ROOT_DIR/deploy/local/local.env"

if [ -z "$1" ]; then
  echo "Usage: $0 <APP_NAME>"
  exit 1
fi

APP_NAME="$1"

# Update the app, update scripts, run deploy
$SSH_COMMAND "cd $PROJECT_PATH/$APP_NAME && git pull && cd $PROJECT_PATH/microk8s && git pull && ./deploy/deploy.sh $APP_NAME"
