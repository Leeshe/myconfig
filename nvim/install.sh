#!/bin/bash

# DIRS
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
NVIM_DIRECTORY=$HOME/.config/nvim
LOCAL_BIN="/usr/local/bin"

# COLORS
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'
MSG_AREADY_EXIST='ALREADY EXISTS'

echo -e "${YELLOW}Creating nvim's config directory if does not exist.${NC}"
mkdir -p $NVIM_DIRECTORY
if [ $? -eq 0 ]; then
    echo -e "... ${LIGHT_GREEN}OK${NC}"
else
    echo -e "... ${LIGHT_RED}FAIL${NC}"
fi


configs=(
init.vim
java.vim
zsh.vim
mapping.vim
)

# NVIM CONFIGS SYMLINK
echo ""
echo -e "${YELLOW}Creating symlinks for nvim configuration's files${NC}"
for i in "${configs[@]}"; do
    echo -e "${LIGHT_CYAN}+ln -s $CURRENT_DIR/$i $NVIM_DIRECTORY${NC}"
    ln -s $CURRENT_DIR/$i $NVIM_DIRECTORY > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "... ${LIGHT_GREEN}OK${NC}"
    else
        echo -e "... ${LIGHT_RED}${MSG_AREADY_EXIST}${NC}"
    fi
done

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

echo ""
echo -e "${YELLOW}Downloading Neovim (nightly build):${NC}"
NIGHTLY_NVIM="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
echo -e "${LIGHT_CYAN}+wget --quiet $NIGHTLY_NVIM --output-document nvim${NC}"
wget --quiet $NIGHTLY_NVIM --output-document nvim&
WGET_PID=$!
spinner
wait $WGET_PID
NVIM_DOWNLOAD_SUCCESS=$?
if [ $NVIM_DOWNLOAD_SUCCESS -eq 0 ]; then
    echo -e "... ${LIGHT_GREEN}OK${NC}"
else
    echo -e "... ${LIGHT_RED}FAIL${NC}"
fi

echo ""
echo -e "${YELLOW}Making nvim executable${NC}"
echo -e "${LIGHT_CYAN}+chmod +x nvim${NC}"
chmod +x nvim
if [ $? -eq 0 ]; then
    echo -e "... ${LIGHT_GREEN}OK${NC}"
else
    echo -e "... ${LIGHT_RED}FAIL${NC}"
fi

# NVIM SYMLINK
echo ""
echo -e "${YELLOW}Creating symlink for nvim in '$LOCAL_BIN'${NC}"
echo -e "${LIGHT_CYAN}+ln -s $CURRENT_DIR/nvim $LOCAL_BIN${NC}"
ln -s $CURRENT_DIR/nvim $LOCAL_BIN > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo -e "... ${LIGHT_GREEN}OK${NC}"
elif [ $? -eq 100 ]; then
    echo -e "... ${LIGHT_RED}PERMISSION REQUIRED${NC}"
else
    echo -e "... ${LIGHT_RED}${MSG_AREADY_EXIST}${NC}"
fi

# INSTALLING VIM-PLUG
echo ""
echo -e "${YELLOW}Installng Vim-Plug${NC}"
echo -e "${LIGHT_CYAN}+curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim${NC}"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            if [ $? -eq 0 ]; then
                echo -e "... ${LIGHT_GREEN}OK${NC}"
            else
                echo -e "... ${LIGHT_RED}FAIL${NC}"
            fi

# INSTALLING PLUGINS
PLUGINS_DIR="$HOME/.local/share/nvim/plugged"

echo ""
echo -e "${YELLOW}Creating plugins directory${NC}"
echo -e "${LIGHT_CYAN}+mkdir -p $PLUGINS_DIR "
mkdir -p $PLUGINS_DIR > /dev/null 2>&1

# Move to plugins directory
printf "\n"
echo -e "${YELLOW}Moving to plugins directory"
echo -e "${LIGHT_CYAN}+cd $PLUGINS_DIR${NC}"
cd $PLUGINS_DIR > /dev/null 2>&1

plugins=(
itchyny/lightline.vim
TaDaa/vimade
bagrat/vim-buffet
neoclide/coc.nvim
alvan/vim-closetag
skielbasa/vim-material-monokai
junegunn/fzf.vim
liuchengxu/vista.vim
mhinz/vim-startify
easymotion/vim-easymotion
Yggdroot/indentLine
tpope/vim-fugitive
janko/vim-test
Rrethy/vim-illuminate
)

# Git clone plugin
echo ""
echo -e "${YELLOW}Installing nvim's plugins to $PLUGINS_DIR${NC}"
for i in "${plugins[@]}"; do
    printf "${LIGHT_CYAN}+git clone --recursive https://github.com/$i.git${NC}"
    printf "\n$i: "
    eval "git clone --recursive https://github.com/$i.git" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        printf "${LIGHT_GREEN}OK${NC}"
    else
        printf "${LIGHT_PURPLE}ALREADY EXISTS${NC}"
    fi
    printf "\n\n"
done

echo ""
echo -e "${LIGHT_GREEN}Run nvim then update plugins :PlugUpdate${NC}"
