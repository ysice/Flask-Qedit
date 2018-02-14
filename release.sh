#!/bin/bash

DOCKER_IMG="cclouds/finit:pypi"
DOCKER_CON="finit"

function prepare(){

    #cmi=$(git log -n 1 --pretty --format=%h)
    #cmi=$(git describe --tag|sed 's/^v//'| tr '-' '.')
    cmi=$( git describe --tag|sed 's/^v//' | tr '-' '.' | sed 's/.g.*//')
    cp Dockerfile.pypi Dockerfile.release
    uname -s | grep -i darwin > /dev/null
    if [ "$?" -eq 0 ];then
        sed -i ""  "s#0.0.0#$cmi#g" Dockerfile.release
    else
        sed -i "s#0.0.0#$cmi#g" Dockerfile.release
    fi
}

function run(){
    prepare
    echo "docker build image"
    docker build --no-cache -t $DOCKER_IMG -f Dockerfile.release .
    echo "release flask-qedit to pypi"
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