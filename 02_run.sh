#!/bin/bash -e

STUDENT=$1
cd jenkins
IMAGE_NAME="puc-sre/jenkins"
IMAGE_VERSION=$(cat version)
IMAGE_FULLNAME="$IMAGE_NAME:latest"

# Docker
docker run -p 8080:8080 ${IMAGE_FULLNAME}