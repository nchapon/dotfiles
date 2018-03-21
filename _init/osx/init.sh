#!/usr/bin/env bash
#
# Installs macos things.


source $HOME/.dotfiles/env

set -e

# Set macOS defaults
$DOTFILES/_init/osx/set-defaults.sh

# Install software
info "Installing OSX dependencies"
if source $DOTFILES/_init/osx/homebrew.sh | while read -r data; do info "$data"; done
then
    success "Dependencies installed"
else
    fail "Error installing dependencies"
fi

info "Running initializers"
find . -name _init.sh | while read init ; do sh -c "${init}" ; done
