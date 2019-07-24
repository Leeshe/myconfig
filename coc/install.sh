#!/usr/bin/env bash

# Create symlink for coc-settings.json
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
NVIM_DIRECTORY=$HOME/.config/nvim

echo "Creating nvim's config directory if does not exist."
mkdir -p $NVIM_DIRECTORY

configs=(
    coc-settings.json
)

echo "Creating symlinks"
for i in "${configs[@]}"; do
    ln -s $CURRENT_DIR/$i $NVIM_DIRECTORY
done


set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
extensions=(
    coc-clock
    coc-git
    coc-java
    coc-json
    coc-lists
    coc-marketplace
    coc-pairs
    coc-snippets
    coc-xml
)
for i in "${extensions[@]}"
do
    npm install $i --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
done
