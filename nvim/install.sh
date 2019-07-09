#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

NVIM_DIRECTORY=$HOME/.config/nvim

echo "Creating nvim's config directory if does not exist."
mkdir -p $NVIM_DIRECTORY

configs=(
    init.vim
    java.vim
    zsh.vim
    mapping.vim
    coc-settings.json
)

echo "Creating symlinks"
for i in "${configs[@]}"; do
    ln -s $CURRENT_DIR/$i $NVIM_DIRECTORY
done
