#!/bin/bash

#-------------------------------------------------------------------
# @description      directories: current and local binaries
# @constant
#-------------------------------------------------------------------
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOCAL_BIN="/usr/local/bin"

#------------------------------------------------------------------
# @description     color constant
# @constans
#------------------------------------------------------------------
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'
MSG_AREADY_EXIST='ALREADY EXISTS'

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
# @description      Print command and evaluate it
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
# @description      Create nvim directory
#------------------------------------------------------------------
createNvimDirectory() {
    NVIM_DIRECTORY=$HOME/.config/nvim
    MESSAGE="Creating nvim's config directory if does not exist."
    COMMAND="mkdir -p $NVIM_DIRECTORY"

    evaluateCommand "$MESSAGE" "$COMMAND"
}

#------------------------------------------------------------------
# @description      Create neovim's config's symlinks
#------------------------------------------------------------------
createConfigsSymlinks() {
    CONFIGS=(
        init.vim
        zsh.vim
        mapping.vim
        plugins.vim
        plugins_mappings.vim
    )

    for CONFIG in "${CONFIGS[@]}"; do
        MESSAGE_REMOVE="Removing '$CONFIG'"
        COMMAND_REMOVE="rm -f $NVIM_DIRECTORY/$CONFIG"
        evaluateCommand "$MESSAGE_REMOVE" "$COMMAND_REMOVE"

        MESSAGE_SYMLINK="Creating symlink for '$CONFIG'"
        COMMAND_SYMLINK="ln -s $CURRENT_DIR/$CONFIG $NVIM_DIRECTORY"
        evaluateCommand "$MESSAGE_SYMLINK" "$COMMAND_SYMLINK"
    done
}

#------------------------------------------------------------------
# @description      Download nighlty build neovim
#------------------------------------------------------------------
downloadNvim() {
    NIGHTLY_NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
    MESSAGE="Downloading Neovim (nightly build):"
    DOWNLOAD_NVIM_COMMAND="wget --quiet $NIGHTLY_NVIM_URL --output-document nvim"

    evaluateCommand "$MESSAGE" "$DOWNLOAD_NVIM_COMMAND"
}

#------------------------------------------------------------------
# @description      Make neovim executable
#------------------------------------------------------------------
makeNvimExecutale() {
    MESSAGE="Making nvim executable"
    CHMOD_NVIM_COMMAND="chmod +x nvim"

    evaluateCommand "$MESSAGE" "$CHMOD_NVIM_COMMAND"
}

#------------------------------------------------------------------
# @description      Create neovim symlink in local binaries
#------------------------------------------------------------------
createNvimSylink() {
    MESSAGE="Creating symlink for nvim in '$LOCAL_BIN'"
    SYMLINK_NVIM_COMMAND="ln -s $CURRENT_DIR/nvim $LOCAL_BIN"

    evaluateCommand "$MESSAGE" "$SYMLINK_NVIM_COMMAND"
}

#------------------------------------------------------------------
# @description      Install vim-plug
#------------------------------------------------------------------
installVimPlug() {
    MESSAGE="Installng Vim-Plug"
    INSTALL_VIM_PLUG_COMMAND="curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    evaluateCommand "$MESSAGE" "$INSTALL_VIM_PLUG_COMMAND"
}

createNvimDirectory
createConfigsSymlinks
downloadNvim
makeNvimExecutale
createNvimSylink
installVimPlug

echo ""
echo -e "${LIGHT_GREEN}Run nvim then update plugins :PlugUpdate${NC}"
exit 0
