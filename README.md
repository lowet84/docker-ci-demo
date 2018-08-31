# docker-ci-demo

## Prerequisites:
You will nedd the following
* A Linux computer/virtual machine that has a public ip and ports 80 and 443 opened.
* Docker https://docs.docker.com/install/
* docker-compose https://docs.docker.com/compose/install/

### DNS
Do one of the following:
* Set up a dns with wildcard subdomains that point to the public ip
* Set up the following subdomains: 
    * portainer.(domain)
    * traefik.(domain)
    * ptraefik.(domain)
    * drone.(domain)
    * docker.(domain)
    * nexus.(domain)
    * gitlab.(domain)
    * demoapp.(domain)


## Network
```
docker create network core
```

# .env file
Copy template.env to a new file called .env

Change SERVER_DOMAIN to your domain (without subdomain example.com)

## Add administrtors to oauth2_proxy
```
docker run --rm -it -v dockercidemo_oauth2proxy:/data alpine sh -c "echo "(admin email)" > /data/emails"
```

# Start containers
```
docker-compose up -d
```

## Configure GitLab
Edit .env file

## Configure Nexus

Go to https://nexus.(domain).  
* Log in with default admin account: admin/admin123
* Create a new user and make sure that the new user is admin.
* Log out and log in with your user. 
* Delete the admin account. (Or change the default password)
* Disable anonymous access
* Go to Administration/Repository/Repositories and delete all repositories
* Add new repository: docker(hosted)
* Name it something useful (Docker) and enable http and set port to 9000

Test that docker registry works by logging in from host
```
docker login docker.(domain)
```

If this fails, go to https://docker.(domain) and try again afterwards. This forces traefik to get ssl certificate from letsencrypt.

# Demo app
Copy app to some other folder  
Init new repo on gogs  
Add all files  

# Enable repo in drone
* Under secrets add docker_username and docker_secret  

# Watchtower
Watchtower watches for changes to the docker image on the registry and pulls and upgrades if a newer image exists.
Set the label: com.centurylinklabs.watchtower.enable=true on all containers that should be updated automatically.
