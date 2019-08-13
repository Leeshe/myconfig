#!/bin/bash

###################################################################
# @constans
# @description:     color constant
###################################################################
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'

###################################################################
# @description      Prints given message in yellow
# @args             $1: message to print
###################################################################
echoMessage() {
    echo -e "${YELLOW}$1${NC}"
}

###################################################################
# @description      Prints given message in cyan
# @args             $1: command to print
###################################################################
echoCommand() {
    commands=()
    for var in "$@"
    do
        commands+=$var" "
    done
    echo -e "${LIGHT_CYAN}+$commands${NC}"
}

###################################################################
# @description      Echo success of last last executed command
# @noargs
###################################################################
echoSuccessFail() {
    if [ $? -eq 0 ]; then
        echo -e "... ${LIGHT_GREEN}OK${NC}"
    else
        echo -e "... ${LIGHT_RED}FAIL${NC}"
    fi
}

###################################################################
# @description      Print command and evalute it
# @args             $1: message to print
#                   $2: command to execute
###################################################################
evaluateCommand() {
    echoMessage "$1"
    echoCommand "$2"
    eval "$2" > /dev/null
    echoSuccessFail
}

###################################################################
# @description      Look for package in 'list_packages' and install them
# @noargs
###################################################################
installPackages() {
    PACKAGES_FILE="list_packages"
    packages=()

    while IFS= read -r package
    do
        packages+=$package" "
    done < "$PACKAGES_FILE"

    MESSAGE="Installing following packages: $packages"
    COMMAND="sudo apt install $packages"

    evaluateCommand "$MESSAGE" "$COMMAND"
}

###################################################################
# @description      Update npm version
# @noargs
###################################################################
updateNpm() {
    MESSAGE="Updating npm"
    COMMAND="npm install -g npm"

    evaluateCommand "$MESSAGE" "$COMMAND"
}

###################################################################
# @description      Install Python3 for Neovim
# @noargs
###################################################################
installPythonForNeovim() {
    MESSAGE="Installing Python3 for Neovim"
    COMMAND="pip3 install neovim"

    evaluateCommand "$MESSAGE" "$COMMAND"
}

installPackages
updateNpm
installPythonForNeovim

exit 0
