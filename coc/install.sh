#!/usr/bin/env bash

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
npm install coc-snippets coc-java coc-json coc-lists coc-marketplace coc-pairs coc-git coc-clock --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
