#!/bin/bash
# Указание текущего рабочего каталога
PWD=$(pwd)

# Создание папки, если она еще не существует
mkdir -p ./apt-confs
mkdir -p ./apt-mirror

# Запись содержимого в apt.conf.sisyphus
cat > ./apt-confs/apt.conf.sisyphus << EOF
Dir::Etc::main "/dev/null";
Dir::Etc::parts "/var/empty";
Dir::Etc::SourceParts "/var/empty";
Dir::Etc::sourcelist "/home/buildovich/apt-confs/sources.list.sisyphus";
EOF

# Запись содержимого в sources.list.sisyphus
cat > ./apt-confs/sources.list.sisyphus << EOF
rpm [alt] http://ftp.altlinux.org/pub/distributions/ALTLinux/ Sisyphus/aarch64 classic
rpm [alt] http://ftp.altlinux.org/pub/distributions/ALTLinux/ Sisyphus/armh classic
rpm [alt] http://ftp.altlinux.org/pub/distributions/ALTLinux/ Sisyphus/i586 classic
rpm [alt] http://ftp.altlinux.org/pub/distributions/ALTLinux/ Sisyphus/noarch classic
rpm [alt] http://ftp.altlinux.org/pub/distributions/ALTLinux/ Sisyphus/ppc64le classic
rpm [alt] http://ftp.altlinux.org/pub/distributions/ALTLinux/ Sisyphus/x86_64 classic
rpm [alt] http://ftp.altlinux.org/pub/distributions/ALTLinux/ Sisyphus/x86_64-i586 classic

rpm http://download.etersoft.ru/pub/download/ximper/ XimperLinuxRepository/x86_64 addon
rpm http://download.etersoft.ru/pub/download/ximper/ XimperLinuxRepository/noarch addon
EOF
