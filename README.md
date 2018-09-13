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
Add your domain to the .env settings file:
```
echo SERVER_DOMAIN=fredriklowenhamn.com > .env
```

## Add administrators to oauth2_proxy
```
docker run --rm -it -v dockercidemo_oauth2proxy:/data alpine sh -c "echo "fredrik.lowenhamn@gmail.com" > /data/emails"
```

# Start containers
```
docker-compose up -d ptraefik presentation
docker-compose up -d
```

## Configure GitLab
Wait for gitlab to start. https://gitlab.fredriklowenhamn.com  

* Change password and login (as root)

* Edit your user and set the same email that was added to oauth2proxy

Test that docker registry works by logging in from host
```
docker login docker.fredriklowenhamn.com
```
If this fails, go to https://docker.fredriklowenhamn.com and try again afterwards. This forces traefik to get ssl certificate from letsencrypt.

### Add application
* Select trusted
* Select all scopes
* Add callbacks
* https://portal.fredriklowenhamn.com/oauth2/callback
* https://drone.fredriklowenhamn.com/authorize

Edit .env file  
```
echo COOKIE_SECRET=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)  >> .env  
echo CLIENT_ID=(Application Id) >> .env  
echo CLIENT_SECRET=(Application Secret) >> .env 
```

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
curl https://raw.githubusercontent.com/lowet84/docker-ci-demo/master/app/docker-compose.yml | DOMAIN=fredriklowenhamn.com REPO=root/demoapp docker-compose -f - up -d
```

# Watchtower
Watchtower watches for changes to the docker image on the registry and pulls and upgrades if a newer image exists.
Set the label: com.centurylinklabs.watchtower.enable=true on all containers that should be updated automatically.

# Continuous Delivery
* Edit and push to check that the continuous delivery is working.

# App reference
### Gitlab
### Portainer
### Drone
### Traefik
### Portal
### Presentation
