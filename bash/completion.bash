#!/usr/bin/env bash
# Bash completion

_macos_completion () {
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
}

_linux_completion () {
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi
}


if is_macOS; then
  _macos_completion
else
  _linux_completion
fi
