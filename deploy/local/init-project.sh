#!/bin/sh
# Stop on any error
set -e

# Load env variables
ROOT_DIR="$(git rev-parse --show-toplevel)"
source "$ROOT_DIR/deploy/local/local.env"

if [ -z "$1" ]; then
  echo "Usage: $0 <APP_NAME> <BRANCH>"
  exit 1
fi

if [ -z "$2" ]; then
  echo "Usage: $0 <APP_NAME> <BRANCH>"
  exit 1
fi

APP_NAME="$1"
BRANCH="$2"

# Update the app, update scripts, run deploy
$SSH_COMMAND "cd $PROJECT_PATH && git clone -b $BRANCH --single-branch $PROJECT_REPO/$APP_NAME && cd microk8s && git pull && ./deploy/deploy.sh $APP_NAME"
