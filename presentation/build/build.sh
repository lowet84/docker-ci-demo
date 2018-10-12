#!/bin/bash
git pull
docker build -t lowet84/docker-ci-presentation .
docker push lowet84/docker-ci-presentation
