#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOCAL_BIN_DIR="/usr/local/bin"

configs=(
    update
    upgrade
    ccl
)

echo "Creating symlinks"
for i in "${configs[@]}"; do
    sudo ln -s $CURRENT_DIR/$i.sh $LOCAL_BIN_DIR/$i
done
