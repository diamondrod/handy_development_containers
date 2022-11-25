#!/bin/bash

## @param $1 Mode: `start` or `stop`
## @param $2 Machine name
## @param $3 Hostname of a new container. Valid only for `Mode: up`.
## @param $4 Location under which a volume of the name of the container exists. Valid only for `Mode: up`.
##  For example, if the absolute path to the volume of a container `Revival` is `/mnt/d/dev/Revival`,
##  the value should be `/mnt/d/dev`.

MODE=$1
MACHINE_NAME=$2
HOST_NAME=$3
VOLUME=$4

if [ ${MODE} = "up" ]; then
    if [ "$3" != "" ]; then
        HOST_CONFIG="--hostname ${HOST_NAME}"
    fi
    docker run -i -d --name ${MACHINE_NAME,,}\
     --mount type=bind,source=${VOLUME}/${MACHINE_NAME},target=/home/${USER}/workspace\
     --mount type=bind,source=${VOLUME}/Shared,target=/home/${USER}/shared\
     ${HOST_CONFIG}\
     ${MACHINE_NAME,,}:latest
elif [ ${MODE} = "start" ]; then
    CONTAINER=$(docker ps -a | grep ${MACHINE_NAME,,} | awk '{print $1}');
    docker start ${CONTAINER};
elif [ ${MODE} = "stop" ]; then
    docker stop ${MACHINE_NAME,,}
elif [ ${MODE} = "down" ]; then
    CONTAINER=$(docker ps -a | grep ${MACHINE_NAME,,} | awk '{print $1}');
    docker stop ${MACHINE_NAME,,}
    docker container rm ${CONTAINER};
else
    echo -e "unknown option: \e[31m${MODE}\e[0m";
    exit 1;
fi
