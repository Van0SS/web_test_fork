source ./deploy/local/local.env
git add . && git commit -m "$@" && git push
ssh -t -oHostKeyAlgorithms=+ssh-dss root@$SERVER_IP 'cd web_test/deploy && git pull && ./deploy.sh'
