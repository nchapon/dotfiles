#!/usr/bin/env bash

source $HOME/.dotfiles/env

_macos_colors () {
    export CLICOLOR=1
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
}


# enable color support of ls and also add handy aliases
_linux_colors () {
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi
}

if is_macOS; then
  _macos_colors
else
  _linux_colors
fi
