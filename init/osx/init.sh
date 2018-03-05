#!/usr/bin/env bash
#
# Installs macos things.


source $HOME/.dotfiles/env

set -e

# Set macOS defaults
$DOTFILES/init/osx/set-defaults.sh

# Install software
info "Installing OSX dependencies"
if source homebrew.sh | while read -r data; do info "$data"; done
then
    success "Dependencies installed"
else
    fail "Error installing dependencies"
fi

info "Running installers"
find . -name install.sh | while read installer ; do sh -c "${installer}" ; done
