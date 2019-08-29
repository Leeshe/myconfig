#!/usr/bin/env bash

set -o nounset    # error when referencing undefined variable

source ../install.sh

echo -e "${BACKGROUND_GREEN}Executing install script in '${PWD##*/}'${NC}"

#------------------------------------------------------------------
# @description:     Directories: current and nvim directories
#------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly NVIM_DIRECTORY=$HOME/.config/nvim

#------------------------------------------------------------------
# @description      Create symlink for coc-settings.json
#------------------------------------------------------------------
createCocSettingsSymlink() {
    # Located in $HOME/.confing/nvim
    readonly COC_SETTING_JSON="coc-settings.json"

    # Create nvim's config directory
    readonly MESSAGE_CREATE_NVIM_DIRECTORY="Creating nvim's config directory if does not exist."
    readonly COMMAND_CREATE_NVIM_DIRECTORY="mkdir -p $NVIM_DIRECTORY"

    evaluateCommand "$MESSAGE_CREATE_NVIM_DIRECTORY" "$COMMAND_CREATE_NVIM_DIRECTORY"

    # Remove existing 'coc-settings.json'
    readonly MESSAGE_REMOVE_COC_SETTINGS_JSON="Removing existing '$COC_SETTING_JSON'"
    readonly COMMAND_REMOVE_COC_SETTINGS_JSON="rm -f $NVIM_DIRECTORY/$COC_SETTING_JSON"

    evaluateCommand "$MESSAGE_REMOVE_COC_SETTINGS_JSON" "$COMMAND_REMOVE_COC_SETTINGS_JSON"

    # Create 'coc-settings.json' symlink
    readonly MESSAGE_CREATE_COC_SETTINGS_SYMLINK="Creating symlink '$COC_SETTING_JSON'"
    readonly COMMAND_CREATE_COC_SETTINGS_SYMLINK="ln -s $CURRENT_DIR/$COC_SETTING_JSON $NVIM_DIRECTORY"

    evaluateCreateSymlink "$MESSAGE_CREATE_COC_SETTINGS_SYMLINK" "$COMMAND_CREATE_COC_SETTINGS_SYMLINK"
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

if [ "${PWD##*/}" == "coc" ]
then
    createCocSettingsSymlink
    echo ""
    installExtensions
    printf "${BACKGROUND_GREEN}END OF 'coc'${NC}"
fi

exit 0
