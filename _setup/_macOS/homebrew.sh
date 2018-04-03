#!/usr/bin/env bash
#
# Install dependnecies

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# Upgrade homebrew
echo "brew update"
brew update

# Run Homebrew through the Brewfile
echo "› brew bundle"
brew bundle
