#!/bin/bash

#-------------------------------------------------------------------
# @description      Directories: current and local binaries
#-------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly LOCAL_BIN="/usr/local/bin"
readonly NVIM_DIRECTORY=$HOME/.config/nvim


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
    readonly MESSAGE_CREATE_NVIM_DIRECTORY="Creating nvim's config directory if does not exist."
    readonly COMMAND_CREATE_NVIM_DIRECTORY="mkdir -p $NVIM_DIRECTORY"

    evaluateCommand "$MESSAGE_CREATE_NVIM_DIRECTORY" "$COMMAND_CREATE_NVIM_DIRECTORY"
}

#------------------------------------------------------------------
# @description      Create neovim's config's symlinks
#------------------------------------------------------------------
createConfigsSymlinks() {
    readonly SYMLINKS=(
        init.vim
        zsh.vim
        mapping.vim
        plugins.vim
        plugins_mappings.vim
    )

    for symlink in "${SYMLINKS[@]}"; do
        messageRemoveSymlinkConfig="Removing '$symlink'"
        commandRemoveSymlinkConfig="rm -f $NVIM_DIRECTORY/$symlink"
        evaluateCommand "$messageRemoveSymlinkConfig" "$commandRemoveSymlinkConfig"

        messageCreateSymlinkConfig="Creating symlink for '$symlink'"
        commandCreateSymlinkConfig="ln -s $CURRENT_DIR/$symlink $NVIM_DIRECTORY"
        evaluateCommand "$messageCreateSymlinkConfig" "$commandCreateSymlinkConfig"
    done
}

#------------------------------------------------------------------
# @description      Download nighlty build neovim
#------------------------------------------------------------------
downloadNvim() {
    readonly NIGHTLY_NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
    readonly MESSAGE_DOWNLOAD_NIGHTLY_BUILD="Downloading Neovim (nightly build):"
    readonly COMMAND_DOWNLOAD_NIGHTLY_NVIM="wget --quiet $NIGHTLY_NVIM_URL --output-document nvim"

    evaluateCommand "$MESSAGE_DOWNLOAD_NIGHTLY_BUILD" "$COMMAND_DOWNLOAD_NIGHTLY_NVIM"
}

#------------------------------------------------------------------
# @description      Make neovim executable
#------------------------------------------------------------------
makeNvimExecutale() {
    readonly MESSAGE_CHMOD_NVIM="Making nvim executable"
    readonly COMMAND_CHMOD_NVIM="chmod +x nvim"

    evaluateCommand "$MESSAGE_CHMOD_NVIM" "$COMMAND_CHMOD_NVIM"
}

#------------------------------------------------------------------
# @description      Create neovim symlink in local binaries
#------------------------------------------------------------------
createNvimSylink() {
    readonly MESSAGE_REMOVE_SYMLINK_NVIM="Removing symlink for 'nvim'"
    readonly COMMAND_REMOVE_SYMLINK_NVIM="rm -f $LOCAL_BIN/nvim"

    evaluateCommand "$MESSAGE_REMOVE_SYMLINK_NVIM" "$COMMAND_REMOVE_SYMLINK_NVIM"

    readonly MESSAGE_CREATE_SYMLINK_NVIM="Creating symlink for nvim in '$LOCAL_BIN'"
    readonly COMMAND_CREATE_SYMLINK_NVIM="ln -s $CURRENT_DIR/nvim $LOCAL_BIN"

    evaluateCommand "$MESSAGE_CREATE_SYMLINK_NVIM" "$COMMAND_CREATE_SYMLINK_NVIM"
}

#------------------------------------------------------------------
# @description      Install vim-plug
#------------------------------------------------------------------
installVimPlug() {
    readonly MESSAGE_INSTALL_VIM_PLUG="Installng Vim-Plug"
    readonly COMMAND_INSTALL_VIM_PLUG="curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    evaluateCommand "$MESSAGE_INSTALL_VIM_PLUG" "$COMMAND_INSTALL_VIM_PLUG"
}

createNvimDirectory
echo
createConfigsSymlinks
echo
downloadNvim
echo
makeNvimExecutale
echo
createNvimSylink
echo
installVimPlug

echo ""
echo -e "${LIGHT_GREEN}Run nvim then update plugins :PlugUpdate${NC}"
exit 0
