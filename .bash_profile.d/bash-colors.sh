#!/usr/bin/env bash

#  From https://github.com/ChristopherA/dotfiles-stow/blob/master/0-shell/.bash_profile
if [[ $(uname) = "Darwin"  ]]; then
    export CLICOLOR=1
fi

export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD


## grep colors to highlight matches
export GREP_OPTIONS='--color=auto'
