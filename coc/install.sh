#!/usr/bin/env bash

set -o nounset    - error when referencing undefined variable

#------------------------------------------------------------------
# @description:     Directories: current and nvim directories
#------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly NVIM_DIRECTORY=$HOME/.config/nvim

#------------------------------------------------------------------
# @description:     Colors constants
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
# @description      Print command and evalute it
# @arg              $1: message to print
# @arg              $2: command to execute
#------------------------------------------------------------------
evaluateCommand() {
    echoMessage   "$1"
    echoCommand   "$2"
    eval "$2" >   /dev/null
    echoSuccessFail
}

#------------------------------------------------------------------
# @description      Create symlink for coc-settings.json
#------------------------------------------------------------------
createCocSettingsSymlink() {
    readonly COC_SETTING_JSON="coc-settings.json"

    MESSAGE_CREATE_NVIM_DIRECTORY="Creating nvim's config directory if does not exist."
    COMMAND_CREATE_NVIM_DIRECTORY="mkdir -p $NVIM_DIRECTORY"
    evaluateCommand "$MESSAGE_CREATE_NVIM_DIRECTORY" "$COMMAND_CREATE_NVIM_DIRECTORY"

    MESSAGE_REMOVE_SYMLINK="Removing symlink '$COC_SETTING_JSON'"
    COMMAND_REMOVE_SYMLINK="rm -f $NVIM_DIRECTORY/$COC_SETTING_JSON"
    evaluateCommand "$MESSAGE_REMOVE_SYMLINK" "$COMMAND_REMOVE_SYMLINK"

    MESSAGE_SYMLINK="Creating symlink '$COC_SETTING_JSON'"
    COMMAND_CREATE_COC_SETTINGS_SYMLINK="ln -s $CURRENT_DIR/$COC_SETTING_JSON $NVIM_DIRECTORY"
    evaluateCommand "$MESSAGE_SYMLINK" "$COMMAND_CREATE_COC_SETTINGS_SYMLINK"
}

#------------------------------------------------------------------
# @description      Loop through 'extensions' and install them
#------------------------------------------------------------------
installExtensions() {
    # Create coc-extensions directory and package.json
    mkdir -p ~/.config/coc/extensions
    cd ~/.config/coc/extensions
    if [ ! -f package.json ]
    then
        echo '{"dependencies":{}}'> package.json
    fi

    # Concatenate extension in 'extensions'
    EXTENSIONS_FILE="${CURRENT_DIR}/extensions"
    extensions=()
    while IFS= read -r extension
    do
        extensions+=$extension" "
    done < "$EXTENSIONS_FILE"

    # Install extensions
    MESSAGE_INSTALL_COC_EXTENSIONS="Installing COC extensions..."
    echoMessage "$MESSAGE_INSTALL_COC_EXTENSIONS"

    for i in "${extensions[@]}"
    do
        COMMAND_INSTALL_EXTENSION="npm install $i --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod"
        eval $COMMAND_INSTALL_EXTENSION
    done
}

createCocSettingsSymlink
echo ""
installExtensions

exit 0
