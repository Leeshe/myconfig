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

# NVIM DIRECTORY
createNvimDirectory() {
    NVIM_DIRECTORY=$HOME/.config/nvim

    echoMessage "Creating nvim's config directory if does not exist."
    mkdir -p $NVIM_DIRECTORY
    if [ $? -eq 0 ]; then
        echo -e "... ${LIGHT_GREEN}OK${NC}"
    else
        echo -e "... ${LIGHT_RED}FAIL${NC}"
    fi
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
        echoCommand $COMMAND
        eval $COMMAND > /dev/null
        echoSuccessFail
    done
}


# NVIM DOWNLOAD
spinner() {
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

downloadNvim() {
    NIGHTLY_NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
    DOWNLOAD_NVIM_COMMAND="wget --quiet $NIGHTLY_NVIM_URL --output-document nvim"

    echoMessage "Downloading Neovim (nightly build):"
    echoCommand $DOWNLOAD_NVIM_COMMAND
    eval $DOWNLOAD_NVIM_COMMAND
    WGET_PID=$!
    spinner

    wait $WGET_PID
    NVIM_DOWNLOAD_SUCCESS=$?
    echoSuccessFail
}


# NVIM EXECUTABLE
makeNvimExecutale() {
    CHMOD_NVIM_COMMAND="chmod +x nvim"

    echoMessage "Making nvim executable"
    echoCommand "CHMOD_NVIM_COMMAND"
    eval $CHMOD_NVIM_COMMAND
    echoSuccessFail
}


# NVIM SYMLINK
createNvimSylink() {
    SYMLINK_NVIM_COMMAND="ln -s $CURRENT_DIR/nvim $LOCAL_BIN"

    echoMessage "Creating symlink for nvim in '$LOCAL_BIN'"
    echoCommand $SYMLINK_NVIM_COMMAND
    eval $SYMLINK_NVIM_COMMAND
    echoSuccessFail
}


# INSTALLING VIM-PLUG
installVimPlug() {
    INSTALL_VIM_PLUG_COMMAND="curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    echoMessage "Installng Vim-Plug"
    echoCommand "$INSTALL_VIM_PLUG_COMMAND"
    eval $INSTALL_VIM_PLUG_COMMAND
    echoSuccessFail
}


# INSTALLING PLUGINS
installPlugins() {
    PLUGINS_DIR="$HOME/.local/share/nvim/plugged"

    # Commands
    CREATE_PLUGINS_DIRECTORY="mkdir -p $PLUGINS_DIR"
    CD_PLUGINS_DIRECTORY="cd $PLUGINS_DIR"

    # Create plugins directory
    echoMessage "Creating plugins directory"
    echoCommand $CREATE_PLUGINS_DIRECTORY
    eval $CREATE_PLUGINS_DIRECTORY > /dev/null 2>&1

    # Move to plugins directory
    printf "\n"
    echoMessage "Moving to plugins directory"
    echoCommand $CD_PLUGINS_DIRECTORY
    eval $CD_PLUGINS_DIRECTORY > /dev/null 2>&1

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

echo -e "${LIGHT_GREEN}Run nvim then update plugins :PlugUpdate${NC}"
