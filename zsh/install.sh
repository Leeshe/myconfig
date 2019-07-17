#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

configs=(
    .zshrc
)

echo "Creating symlinks"
for i in "${configs[@]}"; do
    ln -s $CURRENT_DIR/$i $HOME
done
