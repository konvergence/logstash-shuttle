#!/bin/bash

set -ex

#PARENT_DIR=$(basename "${PWD%/*}")
CURRENT_DIR="${PWD##*/}"
IMAGE_NAME="$CURRENT_DIR"

if [ $# -lt 1 ]; then
    read -p "TAG ?:" TAG
else
   TAG="${1}"
fi


REGISTRY="konvergence"

docker build --no-cache -t ${REGISTRY}/${IMAGE_NAME}:${TAG} -t ${REGISTRY}/${IMAGE_NAME}:latest .

#docker push ${REGISTRY}/${IMAGE_NAME}
