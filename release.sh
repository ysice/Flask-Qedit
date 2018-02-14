#!/bin/bash

DOCKER_IMG="cclouds/finit:pypi"
DOCKER_CON="finit"

function run(){
    echo "docker build image"
    docker build -t $DOCKER_IMG -f Dockerfile.pypi .
    echo "release flask-init to pypi"
    docker run -it --rm  -v ~/.pypirc:~/.pypirc --name $DOCKER_CON $DOCKER_IMG release
    eco "docker delete image"
    docker rmi $DOCKER_IMG
}

case $1 in
    *)
    run
    ;;
esac