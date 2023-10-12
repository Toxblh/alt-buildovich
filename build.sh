#!/bin/bash

PWD=$(pwd)

mkdir -p ./out
sudo podman build . -t builder

REPOSITORY=https://gitlab.eterfund.ru/ximper/mkimage-profiles.git

if [[ $1 == *"ximper"* ]]; then
    if [[ $1 == *"nvidia"* ]]; then
        DISTR=ximper-gnome-nvidia
    else
        DISTR=ximper-gnome
    fi
else
    DISTR=$1
fi 

if [[ -n "$2" ]]; then
    DISTRO_VERSION="$2"
else
    DISTRO_VERSION=0.9
fi

sudo podman run --privileged \
    -v $PWD/out:/home/buildovich/out \
    -v $PWD/apt-confs:/home/buildovich/apt-confs \
    -v $PWD/apt-mirror:/home/buildovich/apt-mirror \
    builder /init.sh $REPOSITORY $DISTR $DISTRO_VERSION