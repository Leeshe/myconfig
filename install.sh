#!/bin/bash

#------------------------------------------------------------------
# @description Directories for configuration
#------------------------------------------------------------------
readonly CURRENT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly NVIM="$CURRENT_DIRECTORY/nvim"
readonly OH_MY_ZSH="$CURRENT_DIRECTORY/oh-my-zsh"

#------------------------------------------------------------------
# @description Colors constants
#------------------------------------------------------------------
readonly LIGHT_RED='\033[1;31m'
readonly YELLOW='\033[1;33m'
readonly LIGHT_CYAN='\033[1;36m'
readonly LIGHT_GREEN='\033[1;32m'
readonly LIGHT_PURPLE='\033[1;35m'
readonly BACKGROUND_GREEN='\e[42m'
readonly NC='\033[0m'

#------------------------------------------------------------------
# @description 'install.sh' is the default name for each script
#------------------------------------------------------------------
readonly INSTALL_SH="install.sh"
readonly CHMOD_X_INSTALL="chmod +x $INSTALL_SH"

#------------------------------------------------------------------
# @description Prints given message in yellow
#
# @arg $1: message to print
#------------------------------------------------------------------
echoMessage() {
	echo -e "${YELLOW}$1${NC}"
}

#------------------------------------------------------------------
# @description Prints given message in cyan
#
# @arg $1: command to print
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
# @description Echo success of last last executed command
#------------------------------------------------------------------
echoSuccessFail() {
	if [ $? -eq 0 ]; then
		echo -e "${LIGHT_GREEN}√${NC}"
	else
		echo -e "${LIGHT_RED}✘${NC}"
	fi
}

#------------------------------------------------------------------
# @description Print command and evaluate it
#
# @arg $1: message to print
# @arg $2: command to execute
#------------------------------------------------------------------
evaluateCommand() {
	echoMessage "$1"
	echoCommand "$2"
	eval "$2" > /dev/null
	echoSuccessFail
}

#------------------------------------------------------------------
# @description Print command en evaluate it
#
# @arg $1: message to print
# @arg $2: command to execute
#------------------------------------------------------------------
evaluateCreateSymlink() {
	echoMessage "$1"
	echoCommand "$2"
	eval "$2" 2> /dev/null
	if [ $? -eq 0 ]; then
		printf "${LIGHT_GREEN}√${NC}\n"
	else
		echo -e "\n${LIGHT_RED}✘ Link already exists${NC}"
	fi
}

#------------------------------------------------------------------
# @description Print command en evaluate it
#
# @arg $1: message to print
# @arg $2: command to execute
#------------------------------------------------------------------
evaluateGitClone() {
	echoMessage "$1"
	echoCommand "$2"
	eval "$2" 2> /dev/null
	case "$?" in
		"128")
			echo -e "\n${LIGHT_RED}✘ Already exists${NC}";;
		"0")
			printf "${LIGHT_GREEN}√${NC}";;
		*)
			echo "Error";;
	esac
}

#------------------------------------------------------------------
# @description Execute install script in given folder
#
# @arg $1: folder
#------------------------------------------------------------------
executeInstallScript() {
	# Move to given folder
	messageCdToFolder="Moving to $1"
	commandCdToFolder="cd $1"

	evaluateCommand "$messageCdToFolder" "$commandCdToFolder"

	# Make install script executable
	messageChmod="Making '$INSTALL_SH' executable"
	commandChmod="$CHMOD_X_INSTALL"

	evaluateCommand "$messageChmod" "$commandChmod"

	# Execute install script
	echoMessage "Executing '$INSTALL_SH' ..."
	./install.sh
}

#------------------------------------------------------------------
# @description Create path variables for neovim in .profile
#------------------------------------------------------------------
createCurrentPathVariable() {
	readonly INIT_VIM="init.vim"
	readonly ZSHRC=".zshrc"
	readonly PROFILE=".zprofile"
	readonly NVIM_INIT_PATH="$NVIM/$INIT_VIM"
	readonly ZSHRC_PATH="$OH_MY_ZSH/$ZSHRC"

	# Remove existing line 'NVIM_INIT=...' in ~/.profile
	readonly MESSAGE_REMOVE_NVIM_INIT_PATH="Removing existing path for '$INIT_VIM' in '$HOME/$PROFILE'"
	readonly COMMAND_REMOVE_NVIM_INIT_PATH="sed -i \"/NVIM_INIT*/d\" $HOME/$PROFILE"

	evaluateCommand "$MESSAGE_REMOVE_NVIM_INIT_PATH" "$COMMAND_REMOVE_NVIM_INIT_PATH"

	# Remove existing line 'ZSHRC_CONFIG=...' in ~/.profile
	readonly MESSAGE_REMOVE_ZSHRC="Removing existing path for '$ZSHRC' in '$HOME/$PROFILE'"
	readonly COMMAND_REMOVE_ZSHRC="sed -i \"/ZSHRC_CONFIG*/d\" $HOME/$PROFILE"

	evaluateCommand "$MESSAGE_REMOVE_ZSHRC" "$COMMAND_REMOVE_ZSHRC"

	# Create path for 'init.vim' in ~/.profile
	readonly MESSAGE_CREATE_NVIM_INIT_PATH="Creating path for '$INIT_VIM' in '$HOME/$PROFILE'"
	readonly COMMAND_CREATE_NVIM_INIT_PATH="echo \"NVIM_INIT=$NVIM_INIT_PATH\" >> $HOME/$PROFILE"

	evaluateCommand "$MESSAGE_CREATE_NVIM_INIT_PATH" "$COMMAND_CREATE_NVIM_INIT_PATH"

	# Create path for '.zshrc' in ~/.profile
	readonly MESSAGE_CREATE_ZSHRC_PATH="Creating path for '$ZSHRC' in '$HOME/$PROFILE'"
	readonly COMMAND_CREATE_ZSHRC_PATH="echo \"ZSHRC_CONFIG=$ZSHRC_PATH\" >> $HOME/$PROFILE"

	evaluateCommand "$MESSAGE_CREATE_ZSHRC_PATH" "$COMMAND_CREATE_ZSHRC_PATH"
}

#------------------------------------------------------------------
# @description Loop through folders and execute install script
#------------------------------------------------------------------
installAll() {
	INSTALLATION_FOLDERS=(
		$OH_MY_ZSH
		$NVIM
	)

	for folder in "${INSTALLATION_FOLDERS[@]}"
	do
		echo ""
		cd $folder
		executeInstallScript $folder
		echoSuccessFail
		cd $CURRENT_DIRECTORY
	done
}

if [ "${PWD##*/}" == "dotfiles" ]
then
	installAll
	createCurrentPathVariable
fi
