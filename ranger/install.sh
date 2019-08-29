#!/bin/bash

set -o nounset    # error when referencing undefined variable

source ../install.sh

echo -e "${BACKGROUND_GREEN}Executing install script in '${PWD##*/}'${NC}"

#-------------------------------------------------------------------
# @description      Directories: current, ranger, local binaries
#-------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly LOCAL_BIN="/usr/local/bin"
readonly RANGER_CONFIG_DIRECTORY=$HOME/.config/ranger
readonly RANGER_PLUGINS_DIRECTORY=$RANGER_CONFIG_DIRECTORY/plugins

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

    evaluteCreateSymlink "$COMMAND_CREATE_SYMLINK_RANGER" "$COMMAND_CREATE_SYMLINK_RANGER"
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

if [ "${PWD##*/}" == "ranger" ]
then
    cloneRanger
    echo
    createRangerSymlink
    echo
    createRangerDirectory
    echo
    createConfigSymlink
    echo
    cloneRangerDevicons
    echo
    createAutojumpSymlink
    printf "${BACKGROUND_GREEN}END OF 'ranger'${NC}"
fi

exit 0
