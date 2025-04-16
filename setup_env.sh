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

# install PyTorch and PyG with pip to set specific CUDA version
pip install -r requirements.txt -f https://data.pyg.org/whl/torch-2.6.0+cu124.html

# optional generation of lockfile:
# conda install -y conda-lock
# conda-lock lock --conda MolSnapper --file env.yml