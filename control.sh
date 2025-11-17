#!/bin/bash

## Consume Mode and machine name
MODE=$1
MACHINE_NAME=$2
shift
shift

## Options
HOST_NAME=""
VOLUME=""
NETWORK=""
PORT_MAP=""

case ${MODE} in
    "up")
        while [[ $# -gt 0 ]]
        do
            case $1 in
                "--host")
                    HOST_NAME="--hostname $2"
                    shift
                    shift
                    ;;
                "--volume")
                    VOLUME=$2;
                    shift
                    shift
                    ;;
                "--network")
                    NETWORK="--network $2"
                    shift
                    shift
                    ;;
                "--port")
                    PORT_MAP="${PORT_MAP} -p $2"
                    shift
                    shift
                    ;;
                *)
                    echo "Unknwon option: $1";
                    ;;
            esac
        done
        docker run -i -d ${NETWORK} ${PORT_MAP} --name ${MACHINE_NAME,,}\
        --mount type=bind,source=${VOLUME}/${MACHINE_NAME},target=/home/${USER}/workspace\
        --mount type=bind,source=${VOLUME}/Shared,target=/home/${USER}/shared\
        ${HOST_NAME}\
        ${MACHINE_NAME,,}:latest
        ;;
    "start")
        CONTAINER=$(docker ps -a | grep ${MACHINE_NAME,,} | awk '{print $1}');
        docker start ${CONTAINER}
        ;;
    "stop")
        docker stop ${MACHINE_NAME,,}
        ;;
    "down")
         CONTAINER=$(docker ps -a | grep ${MACHINE_NAME,,} | awk '{print $1}');
        docker stop ${MACHINE_NAME,,}
        docker container rm ${CONTAINER};
        ;;
    *)
        echo -e "unknown option: \[\e[31m\]${MODE}\[\e[0m\]";
        exit 1
        ;;
esac
