ls --color=auto

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

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
plugins=(git autojump fancy-ctrl-z extract)

source $ZSH/oh-my-zsh.sh
# }}}

# PROMPT {{{

# Hide username
USER=``
# }}}

# ALIAS {{{
alias ls='~/GitHub/coreutils/bin/ls --color=auto'
alias ll='~/GitHub/coreutils/bin/ls -lArth --color=auto'
alias pdf='evince'
alias zshconfig="nvim ~/GitHub/myconfig/.zshrc"
alias neoconfig="nvim ~/GitHub/myconfig/nvim/init.vim"
alias :q=exit
# }}}

# CUSTOM COMMANDS {{{

# ls after cd
function cd {
	builtin cd "$@" && ll
}

nv() {
	nvim $1
}
# }}}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
