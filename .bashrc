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




if [ -d ~/.bash_profile.d ]; then
    for file in ~/.bash_profile.d/*.sh; do
        source $file
    done
fi
