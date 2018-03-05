#!/usr/bin/env bash
#
# Run all topics installers.

source $HOME/.dotfiles/env

set -e

info "Install Ubuntu dependencies"

info "Running installers"

cd $DOTFILES
# find the installers and run them iteratively
find . -name install.sh | while read installer ; do sh -c "${installer}" ; done
