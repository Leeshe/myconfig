#!/bin/bash

#-------------------------------------------------------------------
# @description      Directories: current, ranger, local binaries
#-------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly LOCAL_BIN="/usr/local/bin"
readonly RANGER_CONFIG_DIRECTORY=$HOME/.config/ranger
readonly RANGER_PLUGINS_DIRECTORY=$RANGER_CONFIG_DIRECTORY/plugins


#------------------------------------------------------------------
# @description     Colors constants
#------------------------------------------------------------------
readonly LIGHT_RED='\033[1;31m'
readonly YELLOW='\033[1;33m'
readonly LIGHT_CYAN='\033[1;36m'
readonly LIGHT_GREEN='\033[1;32m'
readonly LIGHT_PURPLE='\033[1;35m'
readonly NC='\033[0m'
readonly MSG_AREADY_EXIST='ALREADY EXISTS'

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
#    echo -e "${LIGHT_CYAN}+$commands${NC}"
    printf "${LIGHT_CYAN}+${commands}${NC}"
}

#------------------------------------------------------------------
# @description      Echo success of last last executed command
#------------------------------------------------------------------
echoSuccessFail() {
    if [ $? -eq 0 ]; then
        echo -e "${LIGHT_GREEN}√${NC}"
    else
        echo -e "${LIGHT_RED}✘${NC}"
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
    readonly MESSAGE_CLONE_RANGER="Git cloning ranger"
    readonly COMMAND_CLONE_RANGER="git clone --recursive https://github.com/ranger/ranger $CURRENT_DIR/.."

    evaluateCommand "$MESSAGE_CLONE_RANGER" "$COMMAND_CLONE_RANGER"
}

#------------------------------------------------------------------
# @description      Create symlink for ranger
#------------------------------------------------------------------
createRangerSymlink() {
    readonly MESSAGE_CREATE_SYMLINK_RANGER="Creating symlink for ranger"
    readonly COMMAND_CREATE_SYMLINK_RANGER="ln -s $CURRENT_DIR/../ranger/ranger.py $LOCAL_BIN/ranger"

    evaluateCommand "$COMMAND_CREATE_SYMLINK_RANGER" "$COMMAND_CREATE_SYMLINK_RANGER"
}

#------------------------------------------------------------------
# @description      Create ranger's config directory
#------------------------------------------------------------------
createRangerDirectory() {
    readonly MESSAGE_CREATE_RANGER_CONFIG_DIRECTORY="Creating ranger's config directory"
    readonly COMMAND_CREATE_RANGER_CONFIG_DIRECTORY="mkdir -p $RANGER_CONFIG_DIRECTORY"

    evaluateCommand "$MESSAGE_CREATE_RANGER_CONFIG_DIRECTORY" "$COMMAND_CREATE_RANGER_CONFIG_DIRECTORY"
}

#------------------------------------------------------------------
# @description      Create ranger's config's symlinks
#------------------------------------------------------------------
createConfigSymlink() {
    readonly CONFIGS=(
        scope.sh
        rc.conf
        rifle.conf
    )

    for symlink in "${CONFIGS[@]}"; do
        messageRemoveSymlinkConfig="Removing '$symlink'"
        commandRemoveSymlinkConfig="rm -f $RANGER_CONFIG_DIRECTORY/$symlink"
        evaluateCommand "$messageRemoveSymlinkConfig" "$commandRemoveSymlinkConfig"

        messageCreateSymlinkConfig="Creating symlink for '$symlink'"
        commandCreateSymlinkConfig="ln -s $CURRENT_DIR/$symlink $RANGER_CONFIG_DIRECTORY"
        evaluateCommand "$messageCreateSymlinkConfig" "$commandCreateSymlinkConfig"
    done
}

#------------------------------------------------------------------
# @description      Clone ranger_devicons
#------------------------------------------------------------------
cloneRangerDevicons() {
    readonly GITHUB_RANGER_DEVICONS="https://github.com/alexanderjeurissen/ranger_devicons"
    readonly MESSAGE_CLONE_RANGER_DEVICONS="Installing 'ranger_devicons'"
    readonly COMMAND_CLONE_RANGER_DEVICONS="git clone $GITHUB_RANGER_DEVICONS $RANGER_PLUGINS_DIRECTORY/ranger_devicons"

    evaluateCommand "$MESSAGE_CLONE_RANGER_DEVICONS" "$COMMAND_CLONE_RANGER_DEVICONS"
}

#------------------------------------------------------------------
# @description      Create autojump.py symlink
#------------------------------------------------------------------
createAutojumpSymlink() {
    readonly AUTOJUMP_PY="autojump.py"

    # Remove existing 'autojump.py'
    readonly MESSAGE_REMOVE_AUTOJUMP="Removing existing '$AUTOJUMP_PY' in '$RANGER_PLUGINS_DIRECTORY'"
    readonly COMMAND_REMOVE_AUTOJUMP="rm -f $RANGER_PLUGINS_DIRECTORY/$AUTOJUMP_PY"

    evaluateCommand "$MESSAGE_REMOVE_AUTOJUMP" "$COMMAND_REMOVE_AUTOJUMP"

    # Create 'autojump.py' symlink
    readonly MESSAGE_CREATE_SYMLINK_AUTOJUMP="Creating symlink '$AUTOJUMP_PY' in '$RANGER_PLUGINS_DIRECTORY'"
    readonly COMMAND_CREATE_SYMLINK_AUTOJUMP="ln -s $CURRENT_DIR/$AUTOJUMP_PY $RANGER_PLUGINS_DIRECTORY/$AUTOJUMP_PY"

    evaluateCommand "$MESSAGE_CREATE_SYMLINK_AUTOJUMP" "$COMMAND_CREATE_SYMLINK_AUTOJUMP"
}

cloneRanger
createRangerSymlink
createRangerDirectory
createConfigSymlink
cloneRangerDevicons
createAutojumpSymlink

exit 0
