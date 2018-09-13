#!/bin/bash

sh reset.sh
docker network create core
docker run --rm -it -v dockercidemo_oauth2proxy:/data alpine sh -c "echo "fredrik.lowenhamn@gmail.com" > /data/emails"
echo SERVER_DOMAIN=fredriklowenhamn.com > .env
docker-compose up -d
