#!/bin/bash

# install homebrew
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

# install packages
brew install coreutils grc encfs vim keychain gpg-agent thefuck planck fzf
brew install emacs --cocoa
brew linkapps
