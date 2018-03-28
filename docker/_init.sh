#!/usr/bin/env bash
# Init docker bash completion

source $HOME/.dotfiles/env

set -e

_docker_macos_completion () {
    etc=/Applications/Docker.app/Contents/Resources/etc
    if [ -d $etc ]; then
        if [ -f  $(brew --prefix)/etc/bash_completion.d/docker ]; then
            success "[docker] Docker shell completion is already installed."
        else
            ln -s $etc/docker.bash-completion $(brew --prefix)/etc/bash_completion.d/docker
            ln -s $etc/docker-machine.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-machine
            ln -s $etc/docker-compose.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-compose
            success "[docker] Docker shell completion is installed."
        fi
    else
        success "[docker] Nothing to do : docker is not installed."
    fi
}

if is_macOS; then
    info "[docker] Install Docker Shell Completion"
    _docker_macos_completion
fi
