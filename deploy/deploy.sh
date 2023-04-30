# Apply k8s updates
microk8s kubectl apply -f ./k8s/

# Build Application image
REPOSITORY_URL="localhost:32000"
APP_NAME="web_test"
APP_TAG="latest"
APP_DIR="../app"

docker build $APP_DIR -t $REPOSITORY_URL/$APP_NAME:$APP_TAG
docker push $REPOSITORY_URL/$APP_NAME:$APP_TAG
microk8s ctr image pull $REPOSITORY_URL/$APP_NAME:$APP_TAG

# Apply application updates
microk8s kubectl rollout restart deployment
