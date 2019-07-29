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

installPackages() {
    PACKAGES_FILE="list_packages"
    packages=()

    while IFS= read -r package
    do
        packages+=$package" "
    done < "$PACKAGES_FILE"

    APT_INSTALL_COMMAND="sudo apt install $packages"

    echoMessage "Installing following packages: $packages"
    echoCommand $APT_INSTALL_COMMAND
    eval $APT_INSTALL_COMMAND
}

installPackages
