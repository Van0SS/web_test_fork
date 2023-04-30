docker build . -t localhost:32000/web_test:latest
docker push localhost:32000/web_test:latest
microk8s ctr image pull localhost:32000/web_test:latest
microk8s kubectl apply -f ./app.yaml
microk8s kubectl rollout restart deployment