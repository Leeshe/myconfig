#!/bin/bash

#-------------------------------------------------------------------
# @constant
# @description      directories: current and local binaries
#-------------------------------------------------------------------
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOCAL_BIN="/usr/local/bin"

#------------------------------------------------------------------
# @constans
# @description:     color constant
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
# @args             $1: message to print
#------------------------------------------------------------------
echoMessage() {
    echo -e "${YELLOW}$1${NC}"
}

#------------------------------------------------------------------
# @description      Prints given message in cyan
# @args             $1: command to print
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
# @noargs
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
# @args             $1: message to print
#                   $2: command to execute
#------------------------------------------------------------------
evaluateCommand() {
    echoMessage "$1"
    echoCommand "$2"
    eval "$2" > /dev/null
    echoSuccessFail
}

#------------------------------------------------------------------
# @description      Create nvim directory
# @noargs
#------------------------------------------------------------------
createNvimDirectory() {
    NVIM_DIRECTORY=$HOME/.config/nvim
    MESSAGE="Creating nvim's config directory if does not exist."
    COMMAND="mkdir -p $NVIM_DIRECTORY"

    evaluateCommand "$MESSAGE" "$COMMAND"
}

#------------------------------------------------------------------
# @description      Create neovim's config's symlinks
# @noargs
#------------------------------------------------------------------
createConfigsSymlinks() {
    CONFIGS=(
        init.vim
        zsh.vim
        mapping.vim
        plugins.vim
        plugins_mappings.vim
    )
    echo ""
    echoMessage "Creating symlinks for nvim configuration's files"
    for i in "${CONFIGS[@]}"; do
        COMMAND="ln -s $CURRENT_DIR/$i $NVIM_DIRECTORY"

        evaluateCommand "" "$COMMAND"
    done
}

#------------------------------------------------------------------
# @description      Download nighlty build neovim
# @noargs
#------------------------------------------------------------------
downloadNvim() {
    NIGHTLY_NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
    MESSAGE="Downloading Neovim (nightly build):"
    DOWNLOAD_NVIM_COMMAND="wget --quiet $NIGHTLY_NVIM_URL --output-document nvim"

    evaluateCommand "$MESSAGE" "$DOWNLOAD_NVIM_COMMAND"
}

#------------------------------------------------------------------
# @description      Make neovim executable
# @noargs
#------------------------------------------------------------------
makeNvimExecutale() {
    MESSAGE="Making nvim executable"
    CHMOD_NVIM_COMMAND="chmod +x nvim"

    evaluateCommand "$MESSAGE" "$CHMOD_NVIM_COMMAND"
}

#------------------------------------------------------------------
# @description      Create neovim symlink in local binaries
# @noargs
#------------------------------------------------------------------
createNvimSylink() {
    MESSAGE="Creating symlink for nvim in '$LOCAL_BIN'"
    SYMLINK_NVIM_COMMAND="ln -s $CURRENT_DIR/nvim $LOCAL_BIN"

    evaluateCommand "$MESSAGE" "$SYMLINK_NVIM_COMMAND"
}

#------------------------------------------------------------------
# @description      Install vim-plug
# @noargs
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
