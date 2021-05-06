#!/bin/bash

set -x

echo "export PATH=\$PATH:\$MPI_ROOT/bin" >> ~/.bashrc
echo "export LIBRARY_PATH=\$LIBRARY_PATH:\$MPI_ROOT/lib" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$MPI_ROOT/lib" >> ~/.bashrc
echo "export C_INCLUDE_PATH=\$C_INCLUDE_PATH:/usr/lib64/openmpi/include/paraview" >> ~/.bashrc
echo "export CPLUS_INCLUDE_PATH=\$CPLUS_INCLUDE_PATH:/usr/lib64/openmpi/include/paraview" >> ~/.bashrc

cd $HOME
mkdir OpenFOAM
cd OpenFOAM
git clone https://github.com/OpenFOAM/OpenFOAM-5.x.git
git clone https://github.com/OpenFOAM/ThirdParty-5.x.git

cd OpenFOAM-5.x
git checkout 538044ac05c4672b37c7df607dca1116fa88df88

source $HOME/OpenFOAM/OpenFOAM-5.x/etc/bashrc

source $HOME/.bashrc

cd $HOME/OpenFOAM/ThirdParty-5.x
mkdir download
wget -P download https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.10/CGAL-4.10.tar.xz
wget -P download https://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.bz2
tar -xJf download/CGAL-4.10.tar.xz
tar -xjf download/boost_1_55_0.tar.bz2

cd ..
sed -i -e 's/\(boost_version=\)boost-system/\1boost_1_55_0/' OpenFOAM-5.x/etc/config.sh/CGAL
sed -i -e 's/\(cgal_version=\)cgal-system/\1CGAL-4.10/' OpenFOAM-5.x/etc/config.sh/CGAL
source $HOME/OpenFOAM/OpenFOAM-5.x/etc/bashrc WM_COMPILER_TYPE=ThirdParty WM_COMPILER=Gcc48 WM_MPLIB=OPENMPI FOAMY_HEX_MESH=yes

echo "alias of5x='source \$HOME/OpenFOAM/OpenFOAM-5.x/etc/bashrc $FOAM_SETTINGS'" >> $HOME/.bashrc

cd $WM_THIRD_PARTY_DIR
wget "https://raw.github.com/wyldckat/scripts4OpenFOAM3rdParty/master/getGcc"
wget "https://raw.github.com/wyldckat/ThirdParty-2.0.x/binutils/makeBinutils"
wget "https://raw.github.com/wyldckat/ThirdParty-2.0.x/binutils/getBinutils"
chmod +x get* make*

./getGcc gcc-4.8.5 gmp-5.1.2 mpfr-3.1.2 mpc-1.0.1
./makeGcc -no-multilib > log.makeGcc 2>&1
wmRefresh

./getBinutils
./makeBinutils gcc-4.8.5 > log.makeBinutils 2>&1
wmRefresh

./makeCGAL > log.makeCGAL 2>&1
wmRefresh

cd $HOME/OpenFOAM/OpenFOAM-5.x

./Allwmake -j$(nproc)

exit(0)

cd $HOME
mkdir CFDEM
cd CFDEM

git clone https://github.com/CFDEMproject/CFDEMcoupling-PUBLIC
cd CFDEMcoupling-PUBLIC


cd $HOME
mkdir LIGGGHTS
cd LIGGGHTS
git clone https://github.com/CFDEMproject/LIGGGHTS-PUBLIC
git clone git://github.com/CFDEMproject/LPP.git lpp

source $WM_PROJECT_DIR/etc/bashrc

cd $HOME/CFDEM
mv CFDEMcoupling-PUBLIC CFDEMcoupling-PUBLIC-$WM_PROJECT_VERSION

cat << EOF >> $HOME/.bashrc
#================================================#
#- source cfdem env vars
export CFDEM_VERSION=PUBLIC
export CFDEM_PROJECT_DIR=\$HOME/CFDEM/CFDEMcoupling-\$CFDEM_VERSION-\$WM_PROJECT_VERSION
export CFDEM_PROJECT_USER_DIR=\$HOME/CFDEM/\$USER-\$CFDEM_VERSION-\$WM_PROJECT_VERSION
export CFDEM_bashrc=\$CFDEM_PROJECT_DIR/src/lagrangian/cfdemParticle/etc/bashrc
export CFDEM_LIGGGHTS_SRC_DIR=\$HOME/LIGGGHTS/LIGGGHTS-PUBLIC/src
export CFDEM_LIGGGHTS_MAKEFILE_NAME=auto
export CFDEM_LPP_DIR=\$HOME/LIGGGHTS/lpp/src

. \$CFDEM_bashrc
#================================================#"
EOF

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
export CFDEM_VERSION=PUBLIC
export CFDEM_PROJECT_DIR=$HOME/CFDEM/CFDEMcoupling-$CFDEM_VERSION-$WM_PROJECT_VERSION
export CFDEM_PROJECT_USER_DIR=$HOME/CFDEM/$USER-$CFDEM_VERSION-$WM_PROJECT_VERSION
export CFDEM_bashrc=$CFDEM_PROJECT_DIR/src/lagrangian/cfdemParticle/etc/bashrc
export CFDEM_LIGGGHTS_SRC_DIR=$HOME/LIGGGHTS/LIGGGHTS-PUBLIC/src
export CFDEM_LIGGGHTS_MAKEFILE_NAME=auto
export CFDEM_LPP_DIR=$HOME/LIGGGHTS/lpp/src

echo "making user dir"
mkdir -p $CFDEM_PROJECT_USER_DIR
cd $CFDEM_PROJECT_USER_DIR
echo "making run dir"
mkdir run
echo "making log dir"
mkdir -p log/logFilesCFDEM-$CFDEM_VERSION-$WM_PROJECT_VERSION
echo "making solvers dir"
mkdir -p applications/solvers
echo "making lib dir"
mkdir -p $CFDEM_PROJECT_DIR/platforms/$WM_OPTIONS/lib
echo "making user lib dir"
mkdir -p $CFDEM_PROJECT_USER_DIR/platforms/$WM_OPTIONS/lib
echo "making app dir"
mkdir -p $CFDEM_PROJECT_DIR/platforms/$WM_OPTIONS/bin
echo "making user app dir"
mkdir -p $CFDEM_PROJECT_USER_DIR/platforms/$WM_OPTIONS/bin

source $CFDEM_bashrc

cfdemCompCFDEMall
