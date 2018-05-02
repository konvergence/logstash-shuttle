#!/bin/bash

set -ex

#PARENT_DIR=$(basename "${PWD%/*}")
CURRENT_DIR="${PWD##*/}"
IMAGE_NAME="slaheddinne.ahmed/$CURRENT_DIR"
TAG="${1}"

REGISTRY="registry.shuttle-cloud.com:5000"

docker build --no-cache -t ${REGISTRY}/${IMAGE_NAME}:${TAG} -t ${REGISTRY}/${IMAGE_NAME}:latest .

#docker push ${REGISTRY}/${IMAGE_NAME}