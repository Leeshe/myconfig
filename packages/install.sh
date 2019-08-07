#!/bin/bash

# COLORS
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'

# FUNCTIONS
echoMessage() {
    echo -e "${YELLOW}$1${NC}..."
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

updateNpm() {
    MESSAGE="Updating npm"
    COMMAND="npm install -g npm"

    evaluateCommand "$MESSAGE" "$COMMAND"
}

installPythonForNeovim() {
    MESSAGE="Installing Python3 for Neovim"
    COMMAND="pip3 install neovim"

    evaluateCommand "$MESSAGE" "$COMMAND"
}

installPackages
updateNpm
installPythonForNeovim

exit 0
