#!/bin/bash

set -o nounset # error when referencing undefined variable

source ../install.sh

echo -e "${BACKGROUND_GREEN}Executing install script in '${PWD##*/}'${NC}"

#------------------------------------------------------------------
# @description Current directory
#------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#------------------------------------------------------------------
# @description  Install oh-my-zsh
#------------------------------------------------------------------
installOhMyZsh() {
	readonly MESSAGE_INSTALL_OH_MY_ZSH="Downloading and installing Oh-My-Zsh"
	readonly COMMAND_INSTALL_OH_MY_ZSH='sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'

	evaluateCommand "$MESSAGE_INSTALL_OH_MY_ZSH" "$COMMAND_INSTALL_OH_MY_ZSH"
}

#------------------------------------------------------------------
# @description Remove current .zshrc and create symlink
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
# @description Install zsh-syntax-highlighting
#------------------------------------------------------------------
installZshSyntaxHighlighting() {
	readonly GITHUB_ZSH_SYNTAX_HIGHLIGHTING="https://github.com/zsh-users/zsh-syntax-highlighting.git"
	readonly MESSAGE_INSTALL_SYNTAX_HIGHLIGHTING="Installing zsh-syntax-highlighting"
	readonly COMMAND_INSTALL_SYNTAX_HIGHLIGHTING="git clone $GITHUB_ZSH_SYNTAX_HIGHLIGHTING  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

	evaluateCommand "$MESSAGE_INSTALL_SYNTAX_HIGHLIGHTING" "$COMMAND_INSTALL_SYNTAX_HIGHLIGHTING"
}

#------------------------------------------------------------------
# @description Install zsh-autosuggestions
#------------------------------------------------------------------
installZshAutosuggestions() {
	readonly GITHUB_ZSH_AUTOSUGGESTIONS="https://github.com/zsh-users/zsh-autosuggestions"
	readonly MESSAGE_INSTALL_AUTOSUGGESTION="Installing zsh-autosuggestions"
	readonly COMMAND_INSTALL_AUTOSUGGESTION="git clone $GITHUB_ZSH_AUTOSUGGESTIONS ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

	evaluateCommand "$MESSAGE_INSTALL_AUTOSUGGESTION" "$COMMAND_INSTALL_AUTOSUGGESTION"
}

if [ "${PWD##*/}" == "oh-my-zsh" ]
then
	installOhMyZsh
	echo
	createSymlink
	echo
	installZshSyntaxHighlighting
	echo
	installZshAutosuggestions
	printf "${BACKGROUND_GREEN}END OF 'oh-my-zsh'${NC}"
fi

exit 0
