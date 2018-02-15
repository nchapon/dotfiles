# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

#export PS1='\u@\h:\W$(__git_ps1 " (%s) " )\$ '

# enable color support of ls and also add handy aliases
# if [ -x /usr/bin/dircolors ]; then
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#     alias ls='ls --color=auto'
#     #alias dir='dir --color=auto'
#     #alias vdir='vdir --color=auto'

#     alias grep='grep --color=auto'
#     alias fgrep='fgrep --color=auto'
#     alias egrep='egrep --color=auto'
# fi

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'


# Terminal colors
        RED="\[\033[0;31m\]"
     ORANGE="\[\033[0;33m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 COLOR_NONE="\[\e[0m\]"


# Basic environment
export TERM=xterm-256color
#export EDITOR=/usr/bin/nano

# Prompt: see http://bashrcgenerator.com/
export PROMPT_DIRTRIM=3
export PS1="\[\033[38;5;2m\]\h:\[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;5m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'



# Java on OS X
if [[ -f /usr/libexec/java_home ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi


# if [ -f ~/.bash_profile ]; then
#     . ~/.bash_profile
# fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#     . /etc/bash_completion
# fi
