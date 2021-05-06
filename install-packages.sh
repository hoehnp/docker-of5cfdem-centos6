#!/bin/bash

set -ux

curl https://www.getpagespeed.com/files/centos6-eol.repo --output /etc/yum.repos.d/CentOS-Base.repo
yum -y check-updates

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
