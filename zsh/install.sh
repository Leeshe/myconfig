#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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

echoSuccessFailGitClone() {
    if [ $1 -eq 0 ]; then
        echo -e "${LIGHT_GREEN}OK${NC}"
    elif [ $1 -eq 128 ]; then
        echo -e "${LIGHT_GREEN}ALREADY PRESENT${NC}"
    else
        echo -e "${LIGHT_RED}FAIL${NC}"
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

installOhMyZsh() {
    MESSAGE="Downloading and installing Oh-My-Zsh..."
    COMMAND='sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'

    evaluateCommand "$MESSAGE" "$COMMAND"
}

createSymlink() {
    MESSAGE_REMOVE_SYMLINK="Removing current .zshrc"
    COMMAND_REMOVE_SYMLINK="rm -rf $HOME/.zshrc"
    evaluateCommand "$MESSAGE_REMOVE_SYMLINK" "$COMMAND_REMOVE_SYMLINK"


    MESSAGE_CREATE_SYMLINK="Creating symlink in $HOME"
    COMMAND_CREATE_SYMLINK="ln -s $CURRENT_DIR/.zshrc $HOME"
    evaluateCommand "$MESSAGE_CREATE_SYMLINK" "$COMMAND_CREATE_SYMLINK"
}

installZshSyntaxHighlighting() {
    MESSAGE="Installing zsh-syntax-highlighting..."
    COMMAND="git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

    echoMessage "$MESSAGE"
    echoCommand "$COMMAND"
    eval "$COMMAND" > /dev/null 2>&1
    echoSuccessFailGitClone $?
}

installZshAutosuggestions() {
    MESSAGE="Installing zsh-autosuggestions..."
    COMMAND="git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

    echoMessage "$MESSAGE"
    echoCommand "$COMMAND"
    eval "$COMMAND" > /dev/null 2>&1
    echoSuccessFailGitClone $?
}

installOhMyZsh
createSymlink
installZshSyntaxHighlighting
installZshAutosuggestions

exit 0
