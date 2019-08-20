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
    echoMessage "$1"
    echoCommand "$2"
    eval "$2" > /dev/null
    echoSuccessFail
}

#------------------------------------------------------------------
# @description      Look for package in 'list_packages' and install them
#------------------------------------------------------------------
installPackages() {
    readonly PACKAGES_FILE="list_packages"
    packages=()

    while IFS= read -r package
    do
        packages+=$package" "
    done < "$PACKAGES_FILE"

    readonly MESSAGE_INSTALL_PACKAGE="Installing following packages: $packages"
    readonly COMMAND_INSTALL_PACKAGE="sudo apt install $packages"

    evaluateCommand "$MESSAGE_INSTALL_PACKAGE" "$COMMAND_INSTALL_PACKAGE"
}

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

installPackages
updateNpm
installPythonForNeovim

exit 0
