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
    * gogs.(domain)
    * demoapp.(domain)


## Network
```
docker create network core
```

# .env file
Copy template.env to a new file called .env

## Oauth2
Set up google oauth by following the instuctions from:
[https://github.com/bitly/oauth2_proxy#google-auth-provider](https://github.com/bitly/oauth2_proxy#google-auth-provider)
Note! Set the Authorized redirect URIs to https://portal.(domain)/oauth2/callback
Edit the following properties in .env
- OAUTH2_PROXY_COOKIE_SECRET, random long string to serve as a secret for your cookie
- OAUTH2_PROXY_COOKIE_DOMAIN, your root domain
- OAUTH2_PROXY_CLIENT_ID, the Client ID from the instuctions above
- OAUTH2_PROXY_CLIENT_SECRET, the Client Secret from the instuctions above
    
## Other settings
- SERVER_DOMAIN=your domain
- SETTINGS_PATH=a path where you want to store all data
- DRONE_ADMIN=username in gogs for use in drone
- DOCKER_CONFIG=/root/.docker/config.json

# Start containers
```
docker-compose up -d
```

## Configure gogs
Go to (https://gogs.(domain)).  
Select Sqlite3 as database  
Enter "gogs.(domain)" as domain  
Set Application URL to: "http://gogs:3000"

Under "Server and Other Services Settings" check:
* Disable self-registration
* Enable require sign in to view pages

Under Admin Account Settings, add your account.

Select Install

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

## Configure Drone

Go to (https://drone.(domain)). 
Log in using your gogs account. (Make sure the account name is the same as you set in DRONE_ADMIN in the .env file)

If you dont want to use gogs, visit http://docs.drone.io/installation/ and check out other options. Edit the docker-compose files and replace the environment variables for other services (like GitHub).

# Demo app
Copy app to some other folder  
Init new repo on gogs  
Add all files  
  
Go to drone and enable repo  
Under secrets add docker_username and docker_secret  

# Watchtower
Watchtower watches for changes to the docker image on the registry and pulls and upgrades if a newer image exists.
Set the label: com.centurylinklabs.watchtower.enable=true on all containers that should be updated automatically.
