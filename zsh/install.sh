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


# INSTALLING OH-MY-ZSH
echo -e "${YELLOW}Downloading and installing Oh-My-Zsh...${NC}"
INSTALL_OHMYZSH='sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
printf "${LIGHT_CYAN}+$INSTALL_OHMYZSH${NC}\n"
eval $INSTALL_OHMYZSH


# SYMLINK
configs=(
    .zshrc
)
# Removing Symlink
REMOVE_SYMLINK="rm -rf $HOME/.zshrc"
echo ""
echo -e "${YELLOW}Removing symlink$ zshrc${NC}"
echo -e "${LIGHT_CYAN}$REMOVE_SYMLINK${NC}"
eval $REMOVE_SYMLINK
# Creating symlink
echo ""
echo -e "${YELLOW}Creating symlink in $HOME${NC}"
for i in "${configs[@]}"; do
    ln -s $CURRENT_DIR/$i $HOME
done
if [ $? -eq 0 ]; then
    echo -e "... ${LIGHT_GREEN}OK${NC}"
else
    echo -e "... ${LIGHT_RED}FAIL${NC}"
fi

exit 0
