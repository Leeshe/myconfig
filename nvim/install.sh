#!/bin/bash

figlet "NVIM"

# DIRS
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOCAL_BIN="/usr/local/bin"


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

# NVIM DIRECTORY
createNvimDirectory() {
    NVIM_DIRECTORY=$HOME/.config/nvim
    MESSAGE="Creating nvim's config directory if does not exist."
    COMMAND="mkdir -p $NVIM_DIRECTORY"

    evaluateCommand "$MESSAGE" "$COMMAND"
}


# NVIM CONFIGS SYMLINK
createConfigsSymlinks() {
    CONFIGS=(
        init.vim
        java.vim
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


# NVIM DOWNLOAD
downloadNvim() {
    NIGHTLY_NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
    MESSAGE="Downloading Neovim (nightly build):"
    DOWNLOAD_NVIM_COMMAND="wget --quiet $NIGHTLY_NVIM_URL --output-document nvim"

    evaluateCommand "$MESSAGE" "$DOWNLOAD_NVIM_COMMAND"
}


# NVIM EXECUTABLE
makeNvimExecutale() {
    MESSAGE="Making nvim executable"
    CHMOD_NVIM_COMMAND="chmod +x nvim"

    evaluateCommand "$MESSAGE" "$CHMOD_NVIM_COMMAND"
}


# NVIM SYMLINK
createNvimSylink() {
    MESSAGE="Creating symlink for nvim in '$LOCAL_BIN'"
    SYMLINK_NVIM_COMMAND="ln -s $CURRENT_DIR/nvim $LOCAL_BIN"

    evaluateCommand "$MESSAGE" "$SYMLINK_NVIM_COMMAND"
}


# INSTALLING VIM-PLUG
installVimPlug() {
    MESSAGE="Installng Vim-Plug"
    INSTALL_VIM_PLUG_COMMAND="curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    evaluateCommand "$MESSAGE" "$INSTALL_VIM_PLUG_COMMAND"
}


# INSTALLING PLUGINS
installPlugins() {
    PLUGINS_DIR="$HOME/.local/share/nvim/plugged"

    # Commands

    # Create plugins directory
    MESSAGE_CREATE_PLUGINS_DIRECTORY="Creating plugins directory"
    CREATE_PLUGINS_DIRECTORY_COMMAND="mkdir -p $PLUGINS_DIR"
    evaluateCommand "$MESSAGE_CREATE_PLUGINS_DIRECTORY" "$CREATE_PLUGINS_DIRECTORY_COMMAND"

    # Move to plugins directory
    echo ""
    MESSAGE_CD_PLUGINS_DIRECTORY="Moving to plugins directory"
    CD_PLUGINS_DIRECTORY_COMMAND="cd $PLUGINS_DIR"
    evaluateCommand "$MESSAGE_CD_PLUGINS_DIRECTORY" "$CD_PLUGINS_DIRECTORY_COMMAND"

    # Git clone plugin
    plugins=(
    )

    PLUG="Plug"
    PLUG_FILE="$CURRENT_DIR/plugins.vim"
    while IFS= read -r line
    do
        stringarray=($line)
        if [[ ${stringarray[0]} == "$PLUG" ]]; then
            output=$( echo ${stringarray[1]} | tr -d \' )
            plugins+=($output)
        fi
    done < "$PLUG_FILE"

    echo ""
    echoMessage "Installing nvim's plugins to $PLUGINS_DIR"

    for i in "${plugins[@]}"; do
        GIT_CLONE_PLUGIN_COMMAND="git clone --recursive https://github.com/$i.git"
        printf "${LIGHT_CYAN}+$GIT_CLONE_PLUGIN_COMMAND${NC}"
        printf "\n$i: "
        eval "git clone --recursive https://github.com/$i.git" > /dev/null 2>&1
        eval $GIT_CLONE_PLUGIN_COMMAND > /dev/null 2>&1
        echoSuccessFailGitClone $?
        printf "\n"
    done
}


createNvimDirectory
createConfigsSymlinks
downloadNvim
makeNvimExecutale
createNvimSylink
installVimPlug
installPlugins

echo ""
echo -e "${LIGHT_GREEN}Run nvim then update plugins :PlugUpdate${NC}"
