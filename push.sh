git add . && git commit -m "$@" && git push
ssh -t -oHostKeyAlgorithms=+ssh-dss root@198.199.78.103 'cd web_test && git pull && ./deploy.sh'