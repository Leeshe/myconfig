#!/bin/bash

###################################################################
# @constant
# @description     current directory
###################################################################
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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
MSG_AREADY_EXIST='ALREADY EXISTS'

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
# @description      Install oh-my-zsh
# @noargs
###################################################################
installOhMyZsh() {
    MESSAGE="Downloading and installing Oh-My-Zsh..."
    COMMAND='sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'

    evaluateCommand "$MESSAGE" "$COMMAND"
}

###################################################################
# @description      Remove current .zshrc and create symlink
# @noargs
###################################################################
createSymlink() {
    MESSAGE_REMOVE_SYMLINK="Removing current .zshrc"
    COMMAND_REMOVE_SYMLINK="rm -rf $HOME/.zshrc"
    evaluateCommand "$MESSAGE_REMOVE_SYMLINK" "$COMMAND_REMOVE_SYMLINK"


    MESSAGE_CREATE_SYMLINK="Creating symlink in $HOME"
    COMMAND_CREATE_SYMLINK="ln -s $CURRENT_DIR/.zshrc $HOME"
    evaluateCommand "$MESSAGE_CREATE_SYMLINK" "$COMMAND_CREATE_SYMLINK"
}

###################################################################
# @description      Install zsh-syntax-highlighting
# @noargs
###################################################################
installZshSyntaxHighlighting() {
    MESSAGE="Installing zsh-syntax-highlighting..."
    COMMAND="git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

    evaluateCommand "$MESSAGE" "$COMMAND"
}

###################################################################
# @description      Install zsh-autosuggestions
#noargs
###################################################################
installZshAutosuggestions() {
    MESSAGE="Installing zsh-autosuggestions..."
    COMMAND="git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

    evaluateCommand "$MESSAGE" "$COMMAND"
}

installOhMyZsh
createSymlink
installZshSyntaxHighlighting
installZshAutosuggestions

exit 0
