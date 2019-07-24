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

INSTALL_SH="install.sh"
CHMOD_X_INSTALL="chmod +x $INSTALL_SH"

# FUNCTIONS
echoMessage() {
    echo -e "${YELLOW}$1${NC}"
}

echoCommand() {
    echo -e "${LIGHT_CYAN}+$1${NC}"
}

echoSuccessFail() {
    if [ $? -eq 0 ]; then
        echo -e "... ${LIGHT_GREEN}OK${NC}"
    else
        echo -e "... ${LIGHT_RED}FAIL${NC}"
    fi
}

executeInstallScript() {
    CD_TO_INSTALL_FOLDER="cd $1"

    echoMessage "Moving to $1"
    echoCommand $CD_TO_INSTALL_FOLDER
    eval $CD_TO_INSTALL_FOLDER

    echo ""
    echoMessage "Making '$INSTALL_SH' executable"
    echoCommand "$CHMOD_X_INSTALL"
    eval $CHMOD_X_INSTALL

    echo ""
    echoMessage "Executing '$INSTALL_SH' ..."
    ./install.sh
}

# Serious business
executeInstallScript $BASH_SCRIPT_FOLDER
echoSuccessFail
