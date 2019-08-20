#!/bin/bash

#------------------------------------------------------------------
# @description      Directories for configuration
#------------------------------------------------------------------
readonly CURRENT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly BASH="$CURRENT_DIRECTORY/bash_script"
readonly COC="$CURRENT_DIRECTORY/coc"
readonly NVIM="$CURRENT_DIRECTORY/nvim"
readonly PACKAGES="$CURRENT_DIRECTORY/packages"
readonly ZSH="$CURRENT_DIRECTORY/zsh"

#------------------------------------------------------------------
# @description      Color constant
#------------------------------------------------------------------
readonly LIGHT_RED='\033[1;31m'
readonly YELLOW='\033[1;33m'
readonly LIGHT_CYAN='\033[1;36m'
readonly LIGHT_GREEN='\033[1;32m'
readonly LIGHT_PURPLE='\033[1;35m'
readonly NC='\033[0m'

#------------------------------------------------------------------
# @description      'install.sh' is the default name for each script
#------------------------------------------------------------------
readonly INSTALL_SH="install.sh"
readonly CHMOD_X_INSTALL="chmod +x $INSTALL_SH"

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
# @description      Execute install script in given folder
# @arg              $1: folder
#------------------------------------------------------------------
executeInstallScript() {
    messageCdToFolder="Moving to $1"
    commandCdToFolder="cd $1"

    evaluateCommand "$messageCdToFolder" "$commandCdToFolder"

    messageChmod="Making '$INSTALL_SH' executable"
    commandChmod="$CHMOD_X_INSTALL"

    evaluateCommand "$messageChmod" "$commandChmod"

    echoMessage "Executing '$INSTALL_SH' ..."
    ./install.sh
}

#------------------------------------------------------------------
# @description      Loop through folders and execute install script
# @noargs
#------------------------------------------------------------------
installAll() {
    INSTALLATION_FOLDERS=(
        $PACKAGES
        $BASH
        $ZSH
        $NVIM
        $COC
    )

    for folder in "${INSTALLATION_FOLDERS[@]}"
    do
        echo ""
        cd $folder
        executeInstallScript $folder
        echoSuccessFail
        cd $CURRENT_DIRECTORY
    done
}

installAll

exit 0
