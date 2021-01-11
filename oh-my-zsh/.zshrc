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
plugins=(

	autojump
	command-not-found
	copydir
	cp
	debian
	extract
	fancy-ctrl-z
	git
	zsh-autosuggestions
	zsh-syntax-highlighting

)

source $ZSH/oh-my-zsh.sh
# }}}

# PROMPT {{{

# Hide username
USER=``

# Time
PROMPT='%{$fg[yellow]%}[%D{%L:%M:%S}] '$PROMPT
# }}}

# ALIAS {{{
alias ls='colorls -lX --color=auto'
alias ll='colorls -lArth --color=auto'
alias pdf='evince'
alias nv='nvim'
alias zshconfig="nvim $ZSHRC_CONFIG"
alias neoconfig="nvim $NVIM_INIT"
alias :q=exit
alias gcf="git clean -f"
alias gsf="gco . && gcf" # git super clean
alias moo="fortune | cowsay"
# }}}

# CUSTOM COMMANDS {{{

# ls after cd
function cd {
	builtin cd "$@" && ls
}

# ls on startup
ls
# }}}

# ZSH-AUTOSUGGESTIONS {{{
bindkey '^ ' autosuggest-accept

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=gold,bg=cyan'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

# EXPORT {{{

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Notification for slack, known issue on Ubuntu 16.04
export ELECTRON_USE_UBUNTU_NOTIFIER=1

# Configs for nvim's lspconfig
export JAR=~/GitHub/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.0.v20200915-1508.jar
export GRADLE_HOME=$HOME/gradle
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
export JDTLS_CONFIG=~/GitHub/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux
export WORKSPACE=$HOME/workspace
# }}}

source $(dirname $(gem which colorls))/tab_complete.sh
