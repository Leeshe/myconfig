#!/usr/bin/env bash

set -o nounset    # error when referencing undefined variable

# COLORS
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'
MSG_AREADY_EXIST='ALREADY EXISTS'

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

<< "PARAMETERS"
    $1: string message
    $2: command to evaluate
PARAMETERS
evaluateCommand() {
    echoMessage "$1"
    echoCommand "$2"
    eval "$2" > /dev/null
    echoSuccessFail
}


CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
NVIM_DIRECTORY=$HOME/.config/nvim

createCocSettingsSymlink() {
    MESSAGE="Creating nvim's config directory if does not exist."
    CREATE_NVIM_DIRECTORY_COMMAND="mkdir -p $NVIM_DIRECTORY"
    evaluateCommand "$MESSAGE" "$CREATE_NVIM_DIRECTORY_COMMAND"


    MESSAGE_SYMLINK="Creating symlink"
    CREATE_COC_SETTINGS_SYMLINK_COMMAND="ln -s $CURRENT_DIR/coc-settings.json $NVIM_DIRECTORY"
    evaluateCommand "$MESSAGE_SYMLINK" "$CREATE_COC_SETTINGS_SYMLINK_COMMAND"
}

installExtensions() {
    # Create coc-extensions directory and package.json
    mkdir -p ~/.config/coc/extensions
    cd ~/.config/coc/extensions
    if [ ! -f package.json ]
    then
        echo '{"dependencies":{}}'> package.json
    fi

    EXTENSIONS_FILE="${CURRENT_DIR}/extensions"
    extensions=()
    while IFS= read -r extension
    do
        extensions+=$extension" "
    done < "$EXTENSIONS_FILE"

    MESSAGE="Installing COC extensions..."
    echoMessage "$MESSAGE"

    for i in "${extensions[@]}"
    do
        INSTALL_EXTENSION_COMMAND="npm install $i --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod"
        eval $INSTALL_EXTENSION_COMMAND
    done
}

createCocSettingsSymlink
echo ""
installExtensions

exit 0
