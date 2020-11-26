#! /bin/bash

set -e

cd $HOME
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate r-reticulate

# https://jupyter-notebook.readthedocs.io/en/stable/public_server.html
echo "Set a strong password for the notebook service"
jupyter notebook password
echo ""
echo "If running remotely, browse to port 8888 on this host instead of 'localhost'"
SHELL=/bin/bash jupyter lab --no-browser --ip=0.0.0.0