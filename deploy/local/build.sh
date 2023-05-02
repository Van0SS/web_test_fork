SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/local.env"
GIT_ROOT_DIR="$(git rev-parse --show-toplevel)"
docker build -t $APP_NAME "$GIT_ROOT_DIR/app"
