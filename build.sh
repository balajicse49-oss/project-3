#!/bin/bash

IMAGE_NAME=$1
TAG=$2

echo "Building Docker image..."

docker build -t ${IMAGE_NAME}:${TAG} .

echo "Build completed"
