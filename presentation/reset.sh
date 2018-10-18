#!/bin/bash
docker-compose pull traefik portainer drone-server gitlab drone-agent watchtower portal presentation
docker rm -f $(docker ps -a -q)
#docker rmi -f $(docker image ls -q)
docker volume rm $(docker volume ls | grep traefik -v)
docker network rm core
rm .env
sh presentation/splash.sh
