FROM alt:sisyphus

# TODO 
# 1. Добавить подключаемый кеш пакетов-зеркала https://www.altlinux.org/Hasher/Tips#Кэширование_скачиваемых_apt-ом_пакетов"

# Установка необходимых пакетов, hasher и настройка
RUN apt-get update && \
    apt-get install -y su git etersoft-build-utils hasher gear sisyphus_check rpm-build qa-robot builder-useradd mkimage

# Юзер для сборки
RUN adduser buildovich -G root,bin,daemon,sys,adm,disk,wheel,proc
RUN chgrp -R wheel /tmp
RUN chmod 775 /tmp

# Настройка hasher
RUN mkdir -p /var/lock/subsys/
RUN service hasher-privd start
RUN builder-useradd buildovich

USER buildovich
ENV HOME /home/buildovich
WORKDIR /home/buildovich

RUN git config --global user.email ci@build.org
RUN git config --global user.name "CI Buildovich"

RUN mkdir -p /home/buildovich/build
RUN echo 'workdir=/home/buildovich/build' >> /home/buildovich/.hasher/config

USER root

COPY ./init.sh /init.sh
RUN chmod +x /init.sh
