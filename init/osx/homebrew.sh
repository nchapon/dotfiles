#!/usr/bin/env bash
#
# Install dependnecies

source $HOME/.dotfiles/env

# Upgrade homebrew
echo "brew update"
brew update

# Run Homebrew through the Brewfile
cd $DOTFILES/init/osx
echo "› brew bundle"
brew bundle
