#!/bin/bash

set -ux

yum -y check-updates

yum -y install epel-release
yum -y groupinstall "Development Tools"

echo  "module load mpi/openmpi-x86_64" | tee --append /etc/profile.d/zzActivateOpenMPI.sh

yum install zlib-devel texinfo gstreamer-plugins-base-devel \
libXext-devel libGLU-devel libXt-devel libXrender-devel libXinerama-devel libpng-devel \
libXrandr-devel libXi-devel libXft-devel libjpeg-turbo-devel libXcursor-devel \
readline-devel ncurses-devel

yum -y update
yum list openmpi-devel

ln -s /usr/lib64/openmpi/bin/mpiCC /usr/bin/mpiCC
ln -s /usr/lib64/openmpi/bin/mpic++ /usr/bin/mpic++
ln -s /usr/lib64/openmpi/bin/mpicxx /usr/bin/mpicxx
