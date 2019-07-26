#!/bin/bash

ROOT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# FOLDERS
BASH="$ROOT_DIRECTORY/bash_script"
COC="$ROOT_DIRECTORY/coc"
NVIM="$ROOT_DIRECTORY/nvim"
ZSH="$ROOT_DIRECTORY/zsh"

# COLORS
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'

INSTALL_SH="install.sh"
CHMOD_X_INSTALL="chmod +x $INSTALL_SH"

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
    PACKAGES_FILE="packages"
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

executeInstallScript() {
    CD_TO_INSTALL_FOLDER="cd $1"

    echoMessage "Moving to $1"
    echoCommand $CD_TO_INSTALL_FOLDER
    eval $CD_TO_INSTALL_FOLDER

    echo ""
    echoMessage "Making '$INSTALL_SH' executable"
    echoCommand "$CHMOD_X_INSTALL"
    eval $CHMOD_X_INSTALL

    echo ""
    echoMessage "Executing '$INSTALL_SH' ..."
    ./install.sh
}

installAll() {
    INSTALLATION_FOLDERS=(
        $BASH
        $ZSH
        $NVIM
        $COC
    )

    # Install packages first
    installPackages
    echoSuccessFail

    for folder in "${INSTALLATION_FOLDERS[@]}"
    do
        echo ""
        cd $folder
        executeInstallScript $folder
        echoSuccessFail
        cd $ROOT_DIRECTORY
    done
}

installAll
exit 0
