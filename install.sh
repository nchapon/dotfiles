#!/usr/bin/env bash
set -e

cd `dirname $0`
export DOTFILES=`pwd`

# Backup regular file if exists
function backup {
    local file="$1"
    if [[ -L "$file" ]]; then
        rm "$file"
    elif [[ -e "$file" ]]; then
        mv "$file" "$file.bak"
    fi
}

function link_with_backup {
    local filename="$1"
    local source="$DOTFILES/$filename"
    local target="$HOME/$filename"
    backup "$target"
    ln -s "$source" "$target"
}


link_with_backup .bashrc
link_with_backup .bash_profile
link_with_backup .gitconfig
