# docker-ci-demo

## Prerequisites:
You need a Linux computer/virtual machine that has a public ip and ports 80 and 443 opened.

Install docker

###On ubuntu:
```
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
  
sudo apt-get update

sudo apt-get install docker-ce
```

Install docker-compose

Do one of the following:
- Set up a dns with wildcard subdomains that point to the public ip
- Set up the following subdomains: 
```
portainer.<domain>
traefik.<domain>
ptraefik.<domain>
drone.<domain>
docker.<domain>
nexus.<domain>
gogs.<domain>
```

## Network
```
docker create network core
```

## Start containers
```
docker-compose up -d
```

# Applications
## Portainer
Portainer is a management gui for docker. 
```
the gui is available at portainer.<domain>
```
