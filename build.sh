#!/bin/bash

PWD=$(pwd)
CURRENT_DATE=$(date +"%Y-%m-%d-%H-%M-%S")

mkdir -p ./out
mkdir -p ./log
sudo podman build . -t builder

REPOSITORY=https://gitlab.eterfund.ru/ximper/mkimage-profiles.git
#REPOSITORY=https://github.com/altlinux/mkimage-profiles.git

if [[ $1 == *"ximper"* ]]; then
    if [[ $1 == *"nvidia"* ]]; then
        DISTR=ximper-gnome-nvidia
    else
        DISTR=ximper-gnome
    fi
else
    DISTR=$1
fi

sudo podman run --privileged \
    -v $PWD/out:/home/buildovich/out \
    -v $PWD/log:/home/buildovich/log \
    -v $PWD/apt-confs:/home/buildovich/apt-confs \
    -v $PWD/apt-mirror:/home/buildovich/apt-mirror \
    builder /init.sh $REPOSITORY $DISTR $CURRENT_DATE $DISTRO_VERSION
