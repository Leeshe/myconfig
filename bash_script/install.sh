#!/bin/bash

#------------------------------------------------------------------
# @constans
# @description:     color constant
#------------------------------------------------------------------
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'
MSG_AREADY_EXIST='ALREADY EXISTS'

#------------------------------------------------------------------
# @constant
# @description:     directories: current and local binaries
#------------------------------------------------------------------
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOCAL_BIN="/usr/local/bin"

#------------------------------------------------------------------
# @description      Prints given message in yellow
# @args             $1: message to print
#------------------------------------------------------------------
echoMessage() {
    echo -e "${YELLOW}$1${NC}"
}

#------------------------------------------------------------------
# @description      Create symlinks for bash scripts
# @noargs
#------------------------------------------------------------------
createSymLinks() {
    BASH_SCRIPTS=(
        update
        upgrade
        ccl
    )

    echoMessage "Creating symlinks"
    for i in "${BASH_SCRIPTS[@]}"; do
        sudo ln -s $CURRENT_DIR/$i.sh $LOCAL_BIN_DIR/$i
    done
}

createSymLinks
exit 0
