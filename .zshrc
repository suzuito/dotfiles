# ---------------
# Common settings
# ---------------
# Get rid of "No match found" message.
setopt +o nomatch
# emacs key map
bindkey -e
# completion
autoload -U compinit
compinit
# allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD
# cursor for file selection
zstyle ':completion:*:default' menu select=1
# The color completing
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Classifing listing
zstyle ':completion:*' group_name ''
zstyle ':completion:*:descriptions' format '- %S%d%s'
# history
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt HIST_IGNORE_ALL_DUPS     # ignore duplication command history list
setopt EXTENDED_HISTORY     # save history with date
setopt SHARE_HISTORY        # share command history data
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_SPACE    # ignore a command including space at prefix
# history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# CTRL-P
bindkey "^P" history-beginning-search-backward-end
# CTRL-N
bindkey "^N" history-beginning-search-forward-end
# color
autoload -U colors
colors
# directory
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
DIRSTACKSIZE=16
# prompt
# cursor for file selection
zstyle ':completion:*:default' menu select=1
# aliase
case "${OSTYPE}" in
freebsd*)
    ## ls
    alias ls="ls -G"
    alias l="ls -l -a -h"
    LSCOLORS=ExHxexexbxbxbxdxdxFxFx
    ;;
linux*)
    ## ls
    alias ls="ls --color=auto"
    alias l="ls -l -a -h"
    ;;
esac
alias grep="grep --color"
# compinit for ssh
function print_known_hosts (){
    if [ -f $HOME/.ssh/known_hosts ]; then
        cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
    fi
}
_chache_hosts=($(print_known_hosts))
# sssh
function sssh (){
    scp ~/.zshrc ~/.*_zshrc ~/.tmux.conf $1:
    ssh -A $1
}
# Timestamp generator
alias tg='date "+%s" -d'
# ssh agent for tmux
agent="$HOME/tmp/ssh-agent-$USER"
if [ -S "$SSH_AUTH_SOCK" ]; then
        case $SSH_AUTH_SOCK in
        /tmp/*/agent.[0-9]*)
                ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
        esac
elif [ -S $agent ]; then
        export SSH_AUTH_SOCK=$agent
else
        echo "no ssh-agent"
fi
# prompt
setopt PROMPT_SUBST
prompt_color="%{${fg[cyan]}%}"
export PROMPT="%{$fg[cyan]%}%D{%Y%m%d %T}%{$fg[default]%}%(?.$prompt_color.${fg[red]%}) [%?] %M:%/ %{${fg[default]}%}
%% "

# -------------------
# Specifiled settings
# -------------------
ls ~/.*_zshrc 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
    filesZshrc=`echo ~/.*_zshrc`
    for localZshrc in $filesZshrc; do
        echo $localZshrc
        if [ -f $localZshrc ]; then
            . $localZshrc
        fi
    done
fi

# For maven
M3_HOME=/usr/local/apache-maven-3.3.3
PATH=$PATH:$M3_HOME/bin
# nvm
if [ -d ~/.nvm ]; then
  echo "nvm is installed"
else
  echo "nvm is not installed"
fi
export NVM_DIR=`echo ~/.nvm`
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# pyenv
if [ -d ~/.pyenv ]; then
  echo "pyenv is installed"
else
  echo "pyenv is not installed"
fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH=~/.pyenv/shims:$PATH
# rbenv
if [ -d ~/.rbenv ]; then
  echo "rbenv is installed"
else
  echo "rbenv is not installed"
fi
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=~/.rbenv/shims:$PATH

# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# jenv
# https://github.com/gcuisinier/jenv
eval "$(jenv init -)"
export PATH=~/.jenv/bin:$PATH

# goenv
export GOENV_ROOT=~/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
eval "$(goenv init -)"
export PATH=$GOROOT/bin:$PATH
eval "$(goenv init -)"

# Flutter
export PATH=$PATH:/opt/flutter/bin
