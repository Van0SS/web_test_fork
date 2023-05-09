# Microk8s scripts

Vision:
This repo would host set of scripts to deploy the whole cluster anywhere.

- It uses microk8s for easier Docker managment
- Hosting for now would be AWS EC2, but could be switched to any ubuntu machine anytime. Digital Ocean is a good candidate and could be easily tested.
- This is a private clone of public repo, so we can grab changes from there as the author updates it.

Ideal workflow:
1. Change repo X (dashboard/api/socket).
2. Commit and push to github.
3. Run github workflow to checkout that new change on 'test' server and it automatically deploys it.
4. When merged to 'release' branch it automatically deploys it to 'prod' server.

Intermediate workflow:
1. Change repo X (dashboard/api/socket).
2. Commit and push to github.
3. Run deploy script form local machine which would SSH to selected server and deploy selected app.
E.g.
```
./deploy/local/push.sh dashboard test
```
```
./deploy/local/push.sh api prod
```

### Setup

1. Copy `./deploy/local/local.env.template` to `./deploy/local/local.env` and set all needed variables.
2. Setup GitHub ssh keys

```
ssh-keygen -t rsa -b 4096 -C "YOUR EMAIL"
```

cat /home/ubuntu/.ssh/id_rsa.pub

Paste to GitHub

Note: Ideally it should be company account, not personal.


3. Run:
```
./deploy/local/init.sh
```
4. Run:
```
./deploy/local/push.sh dashboard test
```

### AWS EC2
Machine:
Ubuntu 22 LTS
x86
At least 2 GB RAM
At least 20 GB gp2 (localhost container images need a lot of space)

k8s is sensitive to resources, if any of the 3: RAM, CPU, Disk is not enough - it will not start.

Security:
Open ports 80, 443
Allow SSH, HTTP, HTTPS traffic from anywhere

Wait couple minutes for machine to boot up.

## Troubleshooting

Easy SSH connection:
```
./deploy/local/ssh-server.sh
```

```
microk8s status
```

Get all pods including system:
```
kubectl get all --all-namespaces
```

Logs are not always present, but still:
```
kubectl logs PODNAME(e.g. dashboard-58f74bb7cc-bhv7z)
```

Ingress(NGINX) Logs:
```
kubectl logs NGINX_PODNAME(e.g. nginx-ingress-microk8s-controller-k6bh6) -n ingress
```

Restart cluster:
```
microk8s stop
microk8s start
```

