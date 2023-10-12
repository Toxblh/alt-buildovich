#!/bin/bash

echo "Init script"
echo "Started with args: $@"
echo "REPOSITORY: $1"
echo "DISTR: $2"
echo "DISTRO_VERSION: $4"
echo "DATE: $3"

REPOSITORY=$1
DISTR=$2
DATE=$3
DISTRO_VERSION=$4

service hasher-privd start
su buildovich -c "git clone $REPOSITORY && \
    cd /home/buildovich/mkimage-profiles && \
    make APTCONF=/home/buildovich/apt-confs/apt.conf.sisyphus \
        BUILDLOG=/home/buildovich/log/build-$DATE.log \
        ${DISTRO_VERSION:+DISTRO_VERSION=$DISTRO_VERSION} \
        $DISTR.iso"
