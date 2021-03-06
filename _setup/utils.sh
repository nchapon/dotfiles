#!/usr/bin/env bash
export DOTFILES=$HOME/.dotfiles




# Helpers functions
function echo-info  { printf "\r\033[2K\033[0;34m[ .. ]\033[0m %s\n" "$*"; }
function echo-skip  { printf "\r\033[2K\033[38;05;240m[SKIP]\033[0m %s\n" "$*"; }
function echo-ok    { printf "\r\033[2K\033[0;32m[ OK ]\033[0m %s\n" "$*"; }
function echo-fail  { printf "\r\033[2K\033[0;31m[FAIL]\033[0m %s\n" "$*"; }


info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}



# Library
function _os {
  case $OSTYPE in
    linux*) if   [[ -f /etc/arch-release   ]]; then echo arch
            elif [[ -f /etc/debian_version ]]; then echo debian
            fi ;;
    darwin*) echo macos ;;
    cygwin*) echo cygwin ;;
  esac
}

# OS detection
function is_macOS() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}


function _source {
  [[ -f $1 ]] && source "$1"
}

function _load {
  case $1 in
    /*) source "$1" ;;
    *)  source "$DOTFILES/$1" ;;
  esac
}

function _load_all {
  for file in "$DOTFILES"/**/"$1"; do
    [[ -e $file ]] && source "$file"
  done
}

function get_os() {
  for os in macOS ubuntu; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}


add_path() {
  if [ -s "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1:$PATH"
  fi
}
