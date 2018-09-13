#!/bin/bash

sh reset.sh
docker network create core
docker run --rm -it -v dockercidemo_oauth2proxy:/data alpine sh -c "echo "fredrik.lowenhamn@gmail.com" > /data/emails"
cp template.env .env
sed -i -e 's/\(your\ domain\)/fredriklowenhamn.com/g' .env
docker-compose up -d
