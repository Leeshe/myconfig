# __  __       _____    _
# |  \/  |_   _|__  /___| |__  _ __ ___
# | |\/| | | | | / // __| '_ \| '__/ __|
# | |  | | |_| |/ /_\__ \ | | | | | (__
# |_|  |_|\__, /____|___/_| |_|_|  \___|
#         |___/

fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1) | lolcat
fortune -a /home/rhynes/.oh-my-zsh/plugins/chucknorris/fortunes | cowthink -p

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

#POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_MODE='awesome-fontconfig'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump chucknorris web-search fancy-ctrl-z catimg extract colored-man-pages cp screen dircycle)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases

# Configuration
alias zshconfig="nvim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias neoconfig="nvim ~/.config/nvim/init.vim"
alias snip="nvim ~/.config/nvim/bundle/vim-snippets/snippets/"
# Chuck
alias cco=chuck_cow
alias ccx="fortune -a /home/rhynes/.oh-my-zsh/plugins/chucknorris/fortunes | xcowsay"
alias cca="fortune | cowsay"
# Update vim's bundle repo
alias vb='vimbundle'
# Miscealleanous
alias ls='ls --color=auto'
alias ll='ls -lArth --color=auto'
alias pdf='evince'

# Functions
dn() {
	dict -d wn $1
}

cat() {
	pygmentize -g $1
}

### POWERLEVEL9K SETTINGS
POWERLEVEL9K_COLOR_SCHEME='dark'

### POWERLEVEL9K PROMPT
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_vim_icon time dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status os_icon)

### POWERLEVEL9k FOREGROUND
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='226'
#POWERLEVEL9K_DIR_HOME_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_OS_ICON_BACKGROUND='white'
POWERLEVEL9K_OS_ICON_FOREGROUND='black'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='082'

# POWERLEVEL9K ICON
POWERLEVEL9K_OK_ICON='\uf00c'
POWERLEVEL9K_FOLDER_ICON=$'\ue70e'
POWERLEVEL9K_HOME_ICON=$'\UF015 '
POWERLEVEL9K_HOME_SUB_ICON=$'\uf07c'

# POWERLEVEL9K CUSTOM ICON VIM
POWERLEVEL9K_CUSTOM_VIM_ICON="zsh_vim_icon"
POWERLEVEL9K_CUSTOM_VIM_ICON_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_VIM_ICON_BACKGROUND="022"

zsh_vim_icon() {
	echo '\ue7c5'
}

# POWERLEVEL9K CUSTOM ICON UBUNTU
POWERLEVEL9K_CUSTOM_UBUNTU_ICON="zsh_ubuntu_icon"
POWERLEVEL9K_CUSTOM_UBUNTU_ICON_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_UBUNTU_ICON_BACKGROUND="black"

zsh_ubuntu_icon() {
	echo '\ue73a'
}

# DISPLAY HOSTNAME: empty
DEFAULT_USER=$USER

# LS COLOR DISPLAY
LS_COLORS=$LS_COLORS:'di=1;33:' ; export LS_COLORS
LS_COLORS=$LS_COLORS:'ex=1;96:' ; export LS_COLORS
LS_COLORS=$LS_COLORS:"*.h=;92:"
LS_COLORS=$LS_COLORS:"*.c=;96:"
LS_COLORS=$LS_COLORS:"*.py=;95:"
LS_COLORS=$LS_COLORS:"*.txt=;33"
LS_COLORS=$LS_COLORS:"*.java=;37"
LS_COLORS=$LS_COLORS:"*.hpp=;92:"
LS_COLORS=$LS_COLORS:"*.cpp=;93"

# CTRL P
ctlrp() {
	</dev/tty vim -c CtrlP
}
zle -N ctlrp
bindkey "^p" ctlrp

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# LITTLE FUZZY FINDER
zstyle ':completion:*' matcher-list '' \
	'm:{a-z\-}={A-Z\_}' \
	'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
	'r:|?=** m:{a-z\-}={A-Z\_}'

# For Vim, to not stop the flow when pressing CTRL-S
stty -ixon

export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin

export RUSTPATH=$HOME/.cargo/
export PATH=$PATH:$RUSTPATH/bin
