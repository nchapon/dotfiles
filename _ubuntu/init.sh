#!/usr/bin/env bash
#
# Run all topics installers.

source $HOME/.dotfiles/env

set -e

info "Install Ubuntu dependencies"

info "Running topics initializers"

cd $DOTFILES
# find the installers and run them iteratively
find . -name _init.sh | while read init ; do sh -c "${init}" ; done
