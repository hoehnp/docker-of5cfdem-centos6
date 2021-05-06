#!/bin/bash

set -ux

sed -i "15d" /etc/yum.repos.d/CentOS-Base.repo
sed -i "15s/#baseurl/baseurl/" /etc/yum.repos.d/CentOS-Base.repo
sed -i "15s/mirror/vault/" /etc/yum.repos.d/CentOS-Base.repo
sed -i "22d" /etc/yum.repos.d/CentOS-Base.repo
sed -i "22s/#baseurl/baseurl/" /etc/yum.repos.d/CentOS-Base.repo
sed -i "22s/mirror/vault/" /etc/yum.repos.d/CentOS-Base.repo
sed -i "29d" /etc/yum.repos.d/CentOS-Base.repo
sed -i "29s/#baseurl/baseurl/" /etc/yum.repos.d/CentOS-Base.repo
sed -i "29s/mirror/vault/" /etc/yum.repos.d/CentOS-Base.repo
sed -i "36d" /etc/yum.repos.d/CentOS-Base.repo
sed -i "36s/#baseurl/baseurl/" /etc/yum.repos.d/CentOS-Base.repo
sed -i "36s/mirror/vault/" /etc/yum.repos.d/CentOS-Base.repo
sed -i "44d" /etc/yum.repos.d/CentOS-Base.repo
sed -i "44s/#baseurl/baseurl/" /etc/yum.repos.d/CentOS-Base.repo
sed -i "44s/mirror/vault/" /etc/yum.repos.d/CentOS-Base.repo

yum install -y wget
yum -y check-update

yum -y install epel-release
yum -y groupinstall "Development Tools"

echo  "module load mpi/openmpi-x86_64" | tee --append /etc/profile.d/zzActivateOpenMPI.sh

yum install zlib-devel texinfo gstreamer-plugins-base-devel \
libXext-devel libGLU-devel libXt-devel libXrender-devel libXinerama-devel libpng-devel \
libXrandr-devel libXi-devel libXft-devel libjpeg-turbo-devel libXcursor-devel \
readline-devel ncurses-devel git

yum -y update
yum list openmpi-devel

ln -s /usr/lib64/openmpi/bin/mpiCC /usr/bin/mpiCC
ln -s /usr/lib64/openmpi/bin/mpic++ /usr/bin/mpic++
ln -s /usr/lib64/openmpi/bin/mpicxx /usr/bin/mpicxx
