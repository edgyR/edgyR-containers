#! /bin/bash

set -e

mkdir --parents $HOME/Downloads/Installers
cd $HOME/Downloads/Installers
echo "Downloading Miniforge-pypy3 installer"
wget -q \
  https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge-pypy3-Linux-aarch64.sh
chmod +x Miniforge-pypy3-Linux-aarch64.sh

echo "Installing a fresh copy to '$HOME/miniconda3' ..."
rm -fr $HOME/mambaforge* $HOME/miniforge* $HOME/miniconda*
./Miniforge-pypy3-Linux-aarch64.sh -b -p $HOME/miniconda3 \
  && rm ./Miniforge-pypy3-Linux-aarch64.sh

echo "Initializing conda for 'bash'"
source $HOME/miniconda3/etc/profile.d/conda.sh
conda init bash
conda config --set auto_activate_base false

echo "Creating fresh 'r-reticulate' environment with JupyterLab and cuSignal dependencies"
/usr/bin/time conda env create --quiet --force --file $EDGYR_SCRIPTS/cusignal_jetson_base.yml
conda activate r-reticulate
/usr/bin/time pip install --verbose 'cupy>=8.0.0'

echo "Installing 'cusignal'"
cd $CONDA_PREFIX
mkdir src; cd src
export CUSIGNAL_HOME=$(pwd)/cusignal
git clone https://github.com/rapidsai/cusignal.git $CUSIGNAL_HOME
cd $CUSIGNAL_HOME
./build.sh --allgpuarch
cp -rp $CUSIGNAL_HOME/notebooks $HOME/cusignal-notebooks