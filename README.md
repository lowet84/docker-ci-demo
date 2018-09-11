# docker-ci-demo

## Prerequisites:
You will nedd the following
* A Linux computer/virtual machine that has a public ip and ports 80 and 443 opened.
* Docker https://docs.docker.com/install/
* docker-compose https://docs.docker.com/compose/install/

### DNS
Do one of the following:
* Set up a dns with wildcard subdomains that point to the public ip
* **OR**
* Set up the following subdomains: (CNAME to root domain)
    * portainer.(domain)
    * traefik.(domain)
    * ptraefik.(domain)
    * drone.(domain)
    * docker.(domain)
    * gitlab.(domain)
    * demoapp.(domain)
    * presentation.(domain)
    * portal.(domain)

## Clone repo
* Clone this repo to your machine and go to the *docker-ci-demo* folder.

## Network
Create the network that is used by all apps.
```
docker network create core
```

# .env file
* Copy *template.env* to a new file called *.env*

* Edit *.env* and change SERVER_DOMAIN to your domain (without subdomain, **example.com** ~~gitlab.example.com~~)

## Add administrators to oauth2_proxy
```
docker run --rm -it -v dockercidemo_oauth2proxy:/data alpine sh -c "echo "(admin email)" > /data/emails"
```

# Start containers
```
docker-compose up -d ptraefik presentation
docker-compose up -d
```

## Configure GitLab
Wait for gitlab to start. https://gitlab.(domain)  

* Change password and login (as root)

* Edit your user and set the same email that was added to oauth2proxy

Test that docker registry works by logging in from host
```
docker login docker.(domain)
```
If this fails, go to https://docker.(domain) and try again afterwards. This forces traefik to get ssl certificate from letsencrypt.

### Add application
* Select trusted
* Select all scopes
* Add callbacks
* https://portal.(your domain)/oauth2/callback
* https://drone.(your domain)/authorize

Edit .env file  
Application Id => CLIENT_ID  
Secret => CLIENT_SECRET  

Refresh affected contatiners by running:
```
docker-compose up -d
```

# Demo app
* Go to gitlab and create a new project called *demoapp*  
* Add a readme to the project so that it can be cloned.  

## Enable repo in drone
* Under secrets add docker_username and docker_secret  

## Clone the app

## Copy the files

## Edit *.drone.yml*

## Push

Check the build in drone.

## Start demoapp
```
curl https://raw.githubusercontent.com/lowet84/docker-ci-demo/master/app/docker-compose.yml | DOMAIN=(your domain) REPO=(root/demoapp) docker-compose -f - up -d
```

# Watchtower
Watchtower watches for changes to the docker image on the registry and pulls and upgrades if a newer image exists.
Set the label: com.centurylinklabs.watchtower.enable=true on all containers that should be updated automatically.

## Edit and push to check that the continuous delivery is working.
