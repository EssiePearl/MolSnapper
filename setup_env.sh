#!/usr/bin/env zsh
eval "$(conda shell.zsh hook)"

conda env create -f env.yml
conda deactivate
conda activate MolSnapper
if [[ "$CONDA_DEFAULT_ENV" != "MolSnapper" ]]; then
    echo "❌ Failed to activate Conda environment 'MolSnapper'. Aborting setup."
    exit 1
fi

pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124

pip install torch-scatter torch-sparse torch-cluster torch-spline-conv torch-geometric \
-f https://data.pyg.org/whl/torch-2.6.0+cu124.html

# optional:
# conda install -y conda-lock
# conda-lock lock --conda MolSnapper --file env.yml