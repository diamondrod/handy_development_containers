#!/bin/bash

## @param $1 Machine name
## @param $2 Flag to build without cache.

MACHINE_NAME=$1
NO_CACHE=$2

## Delete old machine image
OLD_MACHINE_IMAGE_ROW=$(grep -w -n ${MACHINE_NAME,,} active_machines.txt)
OLD_MACHINE_IMAGE_ROW_NUMBER=$(echo ${OLD_MACHINE_IMAGE_ROW} | awk -F: '{print $1}')
OLD_MACHINE_IMAGE_ID=$(echo ${OLD_MACHINE_IMAGE_ROW} | awk '{print $2}')
if [ "${OLD_MACHINE_IMAGE_ROW_NUMBER}" != "" ]; then
    echo "remove old image ${OLD_MACHINE_IMAGE_ID}"
    sed -i ${OLD_MACHINE_IMAGE_ROW_NUMBER}d active_machines.txt
    docker image rm ${OLD_MACHINE_IMAGE_ID}
fi

## Build new image
docker build ${NO_CACHE} --build-arg PASSWORD=${CONTAINER_PASSWORD} --build-arg USER=${USER} --file=${MACHINE_NAME}/Dockerfile ${MACHINE_NAME}/ --tag ${MACHINE_NAME,,}:latest

## Record machine image ID
MACHINE_IMAGE_ID=$(docker image ls | grep ${MACHINE_NAME,,} | awk '{print $3}')
echo "${MACHINE_NAME,,} ${MACHINE_IMAGE_ID}" >> active_machines.txt
