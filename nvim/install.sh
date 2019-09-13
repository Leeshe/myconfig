#!/bin/bash

set -o nounset    # error when referencing undefined variable

source ../install.sh

echo -e "${BACKGROUND_GREEN}Executing install script in '${PWD##*/}'${NC}"

#-------------------------------------------------------------------
# @description      Directories: current and local binaries
#-------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly LOCAL_BIN="/usr/local/bin"
readonly NVIM_DIRECTORY=$HOME/.config/nvim

#-------------------------------------------------------------------
# @description      nvim
#-------------------------------------------------------------------
readonly NVIM_APPIMAGE="nvim.appimage"

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
    	vim_settings.vim
        default_mappings.vim
        plugins.vim
        plugins_settings.vim
        custom_commands.vim
        zsh.vim
    )

    for symlink in "${SYMLINKS[@]}"; do
        messageRemoveSymlinkConfig="Removing '$symlink'"
        commandRemoveSymlinkConfig="rm -f $NVIM_DIRECTORY/$symlink"
        evaluateCommand "$messageRemoveSymlinkConfig" "$commandRemoveSymlinkConfig"

        messageCreateSymlinkConfig="Creating symlink for '$symlink'"
        commandCreateSymlinkConfig="ln -s $CURRENT_DIR/$symlink $NVIM_DIRECTORY"
        evaluateCreateSymlink "$messageCreateSymlinkConfig" "$commandCreateSymlinkConfig"

        echo "========================================="
    done
}

#------------------------------------------------------------------
# @description      Download nighlty build neovim
#------------------------------------------------------------------
downloadNvim() {
    readonly NIGHTLY_NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
    readonly MESSAGE_DOWNLOAD_NIGHTLY_BUILD="Downloading Neovim (nightly build):"
    readonly COMMAND_DOWNLOAD_NIGHTLY_NVIM="wget --quiet $NIGHTLY_NVIM_URL --output-document $NVIM_APPIMAGE"

    evaluateCommand "$MESSAGE_DOWNLOAD_NIGHTLY_BUILD" "$COMMAND_DOWNLOAD_NIGHTLY_NVIM"
}

#------------------------------------------------------------------
# @description      Make neovim executable
#------------------------------------------------------------------
makeNvimExecutale() {
    readonly MESSAGE_CHMOD_NVIM="Making $NVIM_APPIMAGE executable"
    readonly COMMAND_CHMOD_NVIM="chmod +x '$NVIM_APPIMAGE'"

    evaluateCommand "$MESSAGE_CHMOD_NVIM" "$COMMAND_CHMOD_NVIM"
}

#------------------------------------------------------------------
# @description      Create neovim symlink in local binaries
#------------------------------------------------------------------
createNvimSylink() {
    readonly SYMLINK_NVIM="nvim"
    readonly MESSAGE_REMOVE_SYMLINK_NVIM="Removing existing symlink '$SYMLINK_NVIM' in '$LOCAL_BIN'"
    readonly COMMAND_REMOVE_SYMLINK_NVIM="rm -f $LOCAL_BIN/$SYMLINK_NVIM"

    evaluateCommand "$MESSAGE_REMOVE_SYMLINK_NVIM" "$COMMAND_REMOVE_SYMLINK_NVIM"

    readonly MESSAGE_CREATE_SYMLINK_NVIM="Creating symlink for '$NVIM_APPIMAGE' in '$LOCAL_BIN'"
    readonly COMMAND_CREATE_SYMLINK_NVIM="ln -s $CURRENT_DIR/$NVIM_APPIMAGE $LOCAL_BIN/$SYMLINK_NVIM"

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


if [ "${PWD##*/}" == "nvim" ]
then
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
    echo -e "${LIGHT_GREEN}Run nvim then update plugins :PlugUpdate${NC}"
    echo ""
    printf "${BACKGROUND_GREEN}END OF 'nvim'${NC}"
fi

exit 0
