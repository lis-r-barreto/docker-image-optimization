#!/bin/bash -e

STUDENT=$1
cd jenkins
IMAGE_NAME="puc-sre/jenkins"
IMAGE_VERSION=$(cat version)
IMAGE_FULLNAME="$IMAGE_NAME:latest"

# Docker
export DOCKER_BUILDKIT=1
docker build . -t $IMAGE_FULLNAME

# Update version file
echo $((IMAGE_VERSION + 1)) > version

echo -e "\n\nImage ${IMAGE_FULLNAME} builded."
