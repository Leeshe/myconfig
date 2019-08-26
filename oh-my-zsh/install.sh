#!/bin/bash

#------------------------------------------------------------------
# @description      Current directory
#------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#------------------------------------------------------------------
# @description      Colors constants
#------------------------------------------------------------------
readonly LIGHT_RED='\033[1;31m'
readonly YELLOW='\033[1;33m'
readonly LIGHT_CYAN='\033[1;36m'
readonly LIGHT_GREEN='\033[1;32m'
readonly LIGHT_PURPLE='\033[1;35m'
readonly NC='\033[0m'
readonly MSG_AREADY_EXIST='ALREADY EXISTS'

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
    printf "${LIGHT_CYAN}+${commands}${NC}"
}

#------------------------------------------------------------------
# @description      Echo success of last last executed command
#------------------------------------------------------------------
echoSuccessFail() {
    if [ $? -eq 0 ]; then
        echo -e "${LIGHT_GREEN}√${NC}"
    else
        echo -e "${LIGHT_RED}✘${NC}"
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
# @description      Install oh-my-zsh
#------------------------------------------------------------------
installOhMyZsh() {
    readonly MESSAGE_INSTALL_OH_MY_ZSH="Downloading and installing Oh-My-Zsh"
    readonly COMMAND_INSTALL_OH_MY_ZSH='sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'

    evaluateCommand "$MESSAGE_INSTALL_OH_MY_ZSH" "$COMMAND_INSTALL_OH_MY_ZSH"
}

#------------------------------------------------------------------
# @description      Remove current .zshrc and create symlink
#------------------------------------------------------------------
createSymlink() {
    # Remove existing '.zshrc'in $HOME
    readonly MESSAGE_REMOVE_SYMLINK="Removing current .zshrc"
    readonly COMMAND_REMOVE_SYMLINK="rm -f $HOME/.zshrc"

    evaluateCommand "$MESSAGE_REMOVE_SYMLINK" "$COMMAND_REMOVE_SYMLINK"

    # Create symlink '.zshrc' in $HOME
    readonly MESSAGE_CREATE_SYMLINK="Creating symlink in $HOME"
    readonly COMMAND_CREATE_SYMLINK="ln -s $CURRENT_DIR/.zshrc $HOME"

    evaluateCommand "$MESSAGE_CREATE_SYMLINK" "$COMMAND_CREATE_SYMLINK"
}

#------------------------------------------------------------------
# @description      Install zsh-syntax-highlighting
#------------------------------------------------------------------
installZshSyntaxHighlighting() {
    readonly GITHUB_ZSH_SYNTAX_HIGHLIGHTING="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    readonly MESSAGE_INSTALL_SYNTAX_HIGHLIGHTING="Installing zsh-syntax-highlighting"
    readonly COMMAND_INSTALL_SYNTAX_HIGHLIGHTING="git clone $GITHUB_ZSH_SYNTAX_HIGHLIGHTING  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

    evaluateCommand "$MESSAGE_INSTALL_SYNTAX_HIGHLIGHTING" "$COMMAND_INSTALL_SYNTAX_HIGHLIGHTING"
}

#------------------------------------------------------------------
# @description      Install zsh-autosuggestions
#------------------------------------------------------------------
installZshAutosuggestions() {
    readonly GITHUB_ZSH_AUTOSUGGESTIONS="https://github.com/zsh-users/zsh-autosuggestions"
    readonly MESSAGE_INSTALL_AUTOSUGGESTION="Installing zsh-autosuggestions"
    readonly COMMAND_INSTALL_AUTOSUGGESTION="git clone $GITHUB_ZSH_AUTOSUGGESTIONS ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

    evaluateCommand "$MESSAGE_INSTALL_AUTOSUGGESTION" "$COMMAND_INSTALL_AUTOSUGGESTION"
}

installOhMyZsh
echo
createSymlink
echo
installZshSyntaxHighlighting
echo
installZshAutosuggestions

exit 0
