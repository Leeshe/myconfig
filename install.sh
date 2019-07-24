#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# FOLDERS
BASH_SCRIPT_FOLDER="$CURRENT_DIR/bash_script"
COC_FOLDER="$CURRENT_DIR/coc"
NVIM_FOLDER="$CURRENT_DIR/nvim"
ZSH_FOLER="$CURRENT_DIR/zsh"

# COLORS
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'

installBashScripts() {
    CD_BASH_SCRIPT="cd $BASH_SCRIPT_FOLDER"
    echo -e "Moving to '$BASH_SCRIPT_FOLDER'"
    echo -e "${LIGHT_CYAN}+$CD_BASH_SCRIPT${NC}"
    eval $CD_BASH_SCRIPT
    echo "Executing .install.sh..."
    echo ""
    ./install.sh
}

installBashScripts
