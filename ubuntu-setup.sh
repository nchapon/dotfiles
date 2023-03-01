#!/bin/bash

COLOR_NONE="\033[0m"
COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_WHITE="\033[1;37m"


_version_check() {
    curver="${1/v/}"; targetver="$2";
    [ "$targetver" = "$(echo -e "$curver\n$targetver" | sort -V | head -n1)" ]
}

install_essential_packages() {
    local -a packages; packages=( \
        build-essential \
        zsh curl \
        software-properties-common \
        cmake cmake-data universal-ctags autoconf pkg-config \
        htop iotop iftop \
        stow \
        ripgrep rlwrap \         
        )

    sudo apt-get install -y ${packages[@]}
}

install_python_packages() {
    sudo apt-get install -y virtualenv virtualenvwrapper
    sudo apt-get install -y python-pip python3-pip
}

install_ppa_git() {
    # https://launchpad.net/~git-core/+archive/ubuntu/ppa
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get update
    sudo apt-get install -y git-all git-extras
}


install_all() {    
    install_essential_packages    
}


# entrypoint script
if [ `uname` != "Linux" ]; then
    echo "Run on Linux (not on Mac OS X)"; exit 1
fi
if [ -n "$1" ]; then
    $1
else
    echo "Usage: $0 [command], where command is one of the following:"
    declare -F | cut -d" " -f3 | grep -v '^_'
fi
