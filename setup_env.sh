#!/usr/bin/env zsh
eval "$(conda shell.zsh hook)"

conda env create -f env.yml
conda deactivate
conda activate MolSnapper
if [[ "$CONDA_DEFAULT_ENV" != "MolSnapper" ]]; then
    echo "❌ Failed to activate Conda environment 'MolSnapper'. Aborting setup."
    exit 1
fi

pip install lmdb

# install PyTorch with pip after creation of conda environment to set specific CUDA version as described here (https://pytorch.org/get-started/locally/)
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124

# install PyTorch Geometric and extensions that match the PyTorch and CUDA versions (change versions if required)
pip install torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric \
-f https://data.pyg.org/whl/torch-2.6.0+cu124.html

# optional generation of lockfile:
# conda install -y conda-lock
# conda-lock lock --conda MolSnapper --file env.yml