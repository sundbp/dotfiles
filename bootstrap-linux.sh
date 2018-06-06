#!/bin/bash

sudo apt update
sudo apt-get install -y direnv python3-dev python3-pip rbenv  \
     wget curl git socat netcat-openbsd software-properties-common keychain locales-all

sudo -H pip3 install --upgrade pip
sudo -H pip3 install thefuck

cd /tmp
EXA_VER=0.8.0
EXA_FILE="exa-linux-x86_64-${EXA_VER}.zip"
wget https://github.com/ogham/exa/releases/download/v${EXA_VER}/${EXA_FILE}
unzip $EXA_FILE
sudo mv exa-linux-x86_64 /usr/local/bin/exa

sudo add-apt-repository ppa:mfikes/planck
sudo apt-get update
sudo apt-get install -y planck

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --completion --key-bindings --update-rc

# emacs
sudo apt-get purge emacs-snapshot-common emacs-snapshot-bin-common emacs-snapshot \
     emacs-snapshot-el emacs-snapshot-gtk emacs23 emacs23-bin-common emacs23-common \
     emacs23-el emacs23-nox emacs23-lucid auctex emacs24 emacs24-bin-common emacs24-common emacs24-common-non-dfsg

sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt-get install -y emacs25

# vim
sudo apt-get install -y vim

# fish
sudo apt-add-repository ppa:fish-shell/release-2
sudo apt-get update
sudo apt-get install -y fish
