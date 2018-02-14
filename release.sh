#!/bin/bash

DOCKER_IMG="cclouds/finit:pypi"
DOCKER_CON="finit"

function prepare(){

    #cmi=$(git log -n 1 --pretty --format=%h)
    cmi=$(git describe --tag|sed 's/^v//'| tr '-' '.')
    cp Dockerfile.pypi Dockerfile.release
    sed -i "s#0.0.0#$cmi#g" Dockerfile.release

}

function run(){
    prepare
    echo "docker build image"
    docker build --no-cache -t $DOCKER_IMG -f Dockerfile.release .
    echo "release flask-init to pypi"
    docker run -it --rm  -v $(echo ~)/.pypirc:/root/.pypirc --name $DOCKER_CON $DOCKER_IMG release
    echo "docker delete image"
    docker rmi $DOCKER_IMG
    rm -rf Dockerfile.release
}

case $1 in
    *)
    run
    ;;
esac