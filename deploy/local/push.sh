SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/local.env"
git add . && git commit -m "$@" && git push
$SSH_COMMAND 'cd git/web_test/deploy && git pull && ./deploy.sh'
