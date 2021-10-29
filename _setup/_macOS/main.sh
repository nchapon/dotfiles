#!/usr/bin/env bash
#
# Installs macos things.

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

set -e

# Set macOS defaults
./set-defaults.sh

# Install software
info "Installing OSX dependencies"
if source homebrew.sh | while read -r data; do info "$data"; done
then
    success "Dependencies installed"
else
    fail "Error installing dependencies"
fi

info "Running initializers"

# find -H "$DOTFILES" -name _init.sh | while read init ; do sh -c "${init}" ; done
