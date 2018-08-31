# docker-ci-demo

## Prerequisites:
You need a Linux computer/virtual machine that has a public ip and ports 80 and 443 opened.

### Install docker (Example for Ubuntu):
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

### Install docker-compose
```
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
```

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

# Start containers
```
docker-compose up -d
```

## Configure GitLab
Edit .env file

## Add administrtors to oauth2_proxy



## Configure Nexus

Go to (https://nexus.(domain)).  
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
  
Go to drone and enable repo  
Under secrets add docker_username and docker_secret  

# Watchtower
Watchtower watches for changes to the docker image on the registry and pulls and upgrades if a newer image exists.
Set the label: com.centurylinklabs.watchtower.enable=true on all containers that should be updated automatically.
