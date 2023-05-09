#!/bin/sh
# Stop on any error
set -e

# Load env variables
ROOT_DIR="$(git rev-parse --show-toplevel)"
source "$ROOT_DIR/deploy/local/local.env"

# Clone these scripts and install microk8s plus dependencies
$SSH_COMMAND "mkdir -p $PROJECT_PATH && cd $PROJECT_PATH && git clone $PROJECT_REPO/microk8s.git && cd microk8s && ./deploy/setup/env-setup.sh"
# Configure microk8s
$SSH_COMMAND "cd $PROJECT_PATH/microk8s && ./deploy/setup/k8s-config.sh"
