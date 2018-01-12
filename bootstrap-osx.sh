#!/bin/bash

# install homebrew
ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"

# install packages
brew install coreutils grc encfs vim keychain gpg-agent thefuck planck fzf
brew install binutils
brew install diffutils
brew install ed --with-default-names
brew install findutils --with-default-names
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls
brew install grep --with-default-names
brew install gzip
brew install screen
brew install watch
brew install wdiff --with-gettext
brew install wget
brew cask install emacs
brew linkapps
