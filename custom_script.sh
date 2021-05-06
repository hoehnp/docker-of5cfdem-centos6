et -x

echo export WM_MPLIB=OPENMPI >> $HOME/.bashrc
echo export MPI_ROOT=\$HOME/foam/foam-extend-4.0/ThirdParty/packages/openmpi-1.8.8/platforms/linux64GccDPOpt >> $HOME/.bashrc
echo export MPI_ARCH_PATH=\$MPI_ROOT >> $HOME/.bashrc
echo export MPI_ARCH_FLAGS="" >> $HOME/.bashrc
echo export MPI_ARCH_INC="-I\$MPI_ARCH_PATH/include" >> $HOME/.bashrc
echo export MPI_ARCH_LIBS="-L\$MPI_ARCH_PATH/lib" >> $HOME/.bashrc

echo "export PATH=\$PATH:\$MPI_ROOT/bin" >> ~/.bashrc
echo "export LIBRARY_PATH=\$LIBRARY_PATH:\$MPI_ROOT/lib" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$MPI_ROOT/lib" >> ~/.bashrc
echo "export C_INCLUDE_PATH=\$C_INCLUDE_PATH:/usr/lib64/openmpi/include/paraview" >> ~/.bashrc
echo "export CPLUS_INCLUDE_PATH=\$CPLUS_INCLUDE_PATH:/usr/lib64/openmpi/include/paraview" >> ~/.bashrc

#cat << EOT >> install.sh
#!/bin/bash
cd $HOME
mkdir foam
cd foam
#export CUDA_ARCH=sm_30
export WM_NCOMPPROCS=$(nproc)
export QT_BIN_DIR=$(which qmake-qt4 | sed 's|/[^/]*$||')
#export CUDA_BIN_DIR=$(which nvcc | sed 's|/[^/]*$||')
export WM_MPLIB=OPENMPI

git clone https://github.com/Unofficial-Extend-Project-Mirror/foam-extend-foam-extend-4.0 foam-extend-4.0
