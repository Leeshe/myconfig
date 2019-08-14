#!/bin/bash

#-------------------------------------------------------------------
# @description      directories: current, ranger, local binaries
# @constant
#-------------------------------------------------------------------
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOCAL_BIN="/usr/local/bin"
RANGER_CONFIG_DIRECTORY=$HOME/.config/ranger


#------------------------------------------------------------------
# @description     color constant
# @constant
#------------------------------------------------------------------
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'
MSG_AREADY_EXIST='ALREADY EXISTS'

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
        echo -e "... ${LIGHT_GREEN}OK${NC}"
    else
        echo -e "... ${LIGHT_RED}FAIL${NC}"
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
# @description      Clone ranger
#------------------------------------------------------------------
cloneRanger() {
    MESSAGE="Git cloning ranger"
    COMMAND="git clone --recursive https://github.com/ranger/ranger $CURRENT_DIR/.."
    evaluateCommand "$MESSAGE" "$COMMAND"
}

#------------------------------------------------------------------
# @description      Create ranger's config directory
#------------------------------------------------------------------
createRangerDirectory() {
    MESSAGE="Creating ranger's config directory"
    COMMAND="mkdir -p $RANGER_CONFIG_DIRECTORY"
    evaluateCommand "$MESSAGE" "$COMMAND"
}

#------------------------------------------------------------------
# @description      Create ranger's config's symlinks
#------------------------------------------------------------------
createConfigSymlink() {
    CONFIGS=(
        scope.sh
        rc.conf
        rifle.conf
    )

    for CONFIG in "${CONFIGS[@]}"; do
        MESSAGE_REMOVE="Removing '$CONFIG'"
        COMMAND_REMOVE="rm -f $RANGER_CONFIG_DIRECTORY/$CONFIG"
        evaluateCommand "$MESSAGE_REMOVE" "$COMMAND_REMOVE"

        MESSAGE_SYMLINK="Creating symlink for '$CONFIG'"
        COMMAND_SYMLINK="ln -s $CURRENT_DIR/$CONFIG $RANGER_CONFIG_DIRECTORY"
        evaluateCommand "$MESSAGE_SYMLINK" "$COMMAND_SYMLINK"
    done
}

cloneRanger
createRangerDirectory
createConfigSymlink

exit 0
