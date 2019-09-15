#!/bin/bash

set -o nounset    # error when referencing undefined variable

source ../install.sh

echo -e "${BACKGROUND_GREEN}Executing install script in '${PWD##*/}'${NC}"

#------------------------------------------------------------------
# @description      Update npm version
#------------------------------------------------------------------
updateNpm() {
    readonly MESSAGE_UPDATE_NPM="Updating npm"
    readonly COMMAND_UPDATE_NPM="npm install -g npm"

    evaluateCommand "$MESSAGE_UPDATE_NPM" "$COMMAND_UPDATE_NPM"
}

#------------------------------------------------------------------
# @description      Install Python3 for Neovim
#------------------------------------------------------------------
installPythonForNeovim() {
    readonly MESSAGE_INSTALL_PYTHON3_NVIM="Installing Python3 for Neovim"
    readonly COMMAND_INSTALL_PYTHON3_NVIM="pip3 install neovim"

    evaluateCommand "$MESSAGE_INSTALL_PYTHON3_NVIM" "$COMMAND_INSTALL_PYTHON3_NVIM"
}

if [ "${PWD##*/}" == "packages" ]
then
    updateNpm
    installPythonForNeovim
    printf "${BACKGROUND_GREEN}END OF 'packages'${NC}"
fi

exit 0
