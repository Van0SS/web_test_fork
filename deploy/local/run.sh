source ./deploy/local/local.env
/bin/sh ./build.sh
docker run --rm -it -p 80:80 $APP_NAME
