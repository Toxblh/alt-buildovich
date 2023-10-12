#!/bin/bash

# Указание текущего рабочего каталога
PWD=$(pwd)

# Создание папки, если она еще не существует
mkdir -p ./apt-confs

# Запись содержимого в apt.conf.sisyphus. /home/buildovich - это путь к домашней папке пользователя buildovich в контейнере
cat > ./apt-confs/apt.conf.sisyphus << EOF
Dir::Etc::main "/dev/null";
Dir::Etc::parts "/var/empty";
Dir::Etc::SourceParts "/var/empty";
Dir::Etc::sourcelist "/home/buildovich/apt-confs/sources.list.sisyphus";
EOF

# Запись содержимого в sources.list.sisyphus. /home/buildovich - это путь к домашней папке пользователя buildovich в контейнере
cat > ./apt-confs/sources.list.sisyphus << EOF
rpm [alt] file:///home/buildovich/apt-mirror/ ALTLinux/Sisyphus/x86_64 classic
rpm [alt] file:///home/buildovich/apt-mirror/ ALTLinux/Sisyphus/noarch classic
rpm [alt] file:///home/buildovich/apt-mirror/ ALTLinux/Sisyphus/x86_64-i586 classic
rpm file:///home/buildovich/apt-mirror XimperLinuxRepository/x86_64 addon
rpm file:///home/buildovich/apt-mirror XimperLinuxRepository/noarch addon
EOF


mkdir -p ./apt-mirror
cd ./apt-mirror

# XimperLinuxRepository
wget -m -nH --cut-dirs=3 ftp://download.etersoft.ru/pub/download/ximper/XimperLinuxRepository

# ALTLinux/Sisyphus TODO: Доработать
rsync --timeout=6000 -avlpztc \
    --exclude 'SRPMS' \
    --exclude 'SRPMS.all' \
    --exclude 'SRPMS.classic' \
    --exclude 'i686' \
    --exclude 'x86_64' \
    --exclude 'x86_32' \
    --stats --delete-after --verbose \
    rsync.altlinux.org::ALTLinux/Sisyphus/ \
    /home/toxblh/apt-mirror/ALTLinux/