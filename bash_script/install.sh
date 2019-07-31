#!/bin/bash

# COLORS
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOCAL_BIN_DIR="/usr/local/bin"

# FUNCTIONS
echoMessage() {
    echo -e "${YELLOW}$1${NC}"
}

echoCommand() {
    commands=()
    for var in "$@"
    do
        commands+=$var" "
    done
    echo -e "${LIGHT_CYAN}+$commands${NC}"
}

echoSuccessFail() {
    if [ $? -eq 0 ]; then
        echo -e "... ${LIGHT_GREEN}OK${NC}"
    else
        echo -e "... ${LIGHT_RED}FAIL${NC}"
    fi
}

createSymLinks() {
    CONFIGS=(
        update
        upgrade
        ccl
    )

    echoMessage "Creating symlinks"
    for i in "${CONFIGS[@]}"; do
        sudo ln -s $CURRENT_DIR/$i.sh $LOCAL_BIN_DIR/$i
    done
}

createSymLinks
exit 0
