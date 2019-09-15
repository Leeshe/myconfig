# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Source .zprofile to get 'NVIM_INIT' and 'ZSHRC_CONFIG'
. ~/.zprofile

# THEME {{{
ZSH_THEME="agnoster"
# }}}

# ZSH SETTINGS {{{
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
#}}}

# PLUGINS {{{
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump fancy-ctrl-z extract command-not-found zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
# }}}

# PROMPT {{{

# Hide username
USER=``
# }}}

# ALIAS {{{
alias ls='/opt/coreutils/bin/ls -lX --color=auto'
alias ll='/opt/coreutils/bin/ls -lArth --color=auto'
alias pdf='evince'
alias zshconfig="nvim $ZSHRC_CONFIG"
alias neoconfig="nvim $NVIM_INIT"
alias :q=exit
alias gcf="git clean -f"
alias gsf="gco . && gcf" # git super clean
# }}}

# CUSTOM COMMANDS {{{

# ls after cd
function cd {
	builtin cd "$@" && ls
}

nv() {
	nvim $1
}

jira() {
    URL="https://jira.france.openpricer/browse/"
    TAG=$(echo $1 | grep -oP "[^(fix|feat)(_)][a-zA-Z0-9\-]*[^(.vim)]")
    firefox $URL$TAG
}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

ls

PROMPT='%{$fg[yellow]%}[%D{%L:%M:%S}] '$PROMPT
bindkey '^ ' autosuggest-accept

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'
