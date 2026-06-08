#!/bin/bash

IMAGE_NAME=$1

docker stop project-3 || true
docker rm project-3 || true

docker run -d \
  --name project-3 \
  -p 80:80 \
  $IMAGE_NAME
