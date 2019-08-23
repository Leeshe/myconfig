#!/bin/bash

#------------------------------------------------------------------
# @description      Colors constants
#------------------------------------------------------------------
readonly LIGHT_RED='\033[1;31m'
readonly YELLOW='\033[1;33m'
readonly LIGHT_CYAN='\033[1;36m'
readonly LIGHT_GREEN='\033[1;32m'
readonly LIGHT_PURPLE='\033[1;35m'
readonly NC='\033[0m'
readonly MSG_AREADY_EXIST='ALREADY EXISTS'

#------------------------------------------------------------------
# @description      Directories: current and local binaries
#------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly LOCAL_BIN="/usr/local/bin"

#------------------------------------------------------------------
# @description      Prints given message in yellow
# @arg              $1: message to print
#------------------------------------------------------------------
echoMessage() {
    echo -e "${YELLOW}$1${NC}"
}

#------------------------------------------------------------------
# @description      Prints given message in cyan
# @arg              $1: command to print
#------------------------------------------------------------------
echoCommand() {
    commands=()
    for var in "$@"
    do
        commands+=$var" "
    done
    echo -e "${LIGHT_CYAN}+$commands${NC}"
}

#------------------------------------------------------------------
# @description      Echo success of last last executed command
#------------------------------------------------------------------
echoSuccessFail() {
    if [ $? -eq 0 ]; then
        echo -e "${LIGHT_GREEN}√ OK${NC}"
    else
        echo -e "${LIGHT_RED}✘ FAIL${NC}"
    fi
}

#------------------------------------------------------------------
# @description      Print command and evaluate it
# @arg              $1: message to print
# @arg              $2: command to execute
#------------------------------------------------------------------
evaluateCommand() {
    echoMessage "$1"
    echoCommand "$2"
    eval "$2" > /dev/null
    echoSuccessFail
}

#------------------------------------------------------------------
# @description      Create symlinks for bash scripts
#------------------------------------------------------------------
createSymLinks() {
    readonly BASH_SCRIPTS=(
        update
        upgrade
        ccl
    )

    for symlink in "${BASH_SCRIPTS[@]}"; do
        messageCreateSymlink="Creating symlink '$symlink'"
        commandCreateSymlink="ln -s $CURRENT_DIR/$symlink.sh $LOCAL_BIN/$symlink"
        evaluateCommand "$messageCreateSymlink" "$commandCreateSymlink"
    done
}

createSymLinks

exit 0
