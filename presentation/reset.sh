#!/bin/bash
docker-compose pull traefik portainer drone-server gitlab drone-agent watchtower portal presentation
docker rm -f $(docker ps -a -q)
#docker rmi -f $(docker image ls -q)
docker volume rm dockercidemo_drone dockercidemo_gitlab_config dockercidemo_gitlab_data dockercidemo_gitlab_logs dockercidemo_gogs dockercidemo_gogs_ssh dockercidemo_portainer
docker network rm core
rm .env
sh presentation/splash.sh
