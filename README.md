# docker-ci-demo

## Prerequisites:
You need a Linux computer/virtual machine that has a public ip and ports 80 and 443 opened.

Install docker

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
