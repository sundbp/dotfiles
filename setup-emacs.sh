#!/bin/bash

if [ "$(uname)" == "Linux" -a ! -e /usr/bin/emacs ];then
    sudo apt-get update
    sudo apt-get install
    sudo apt-get purge emacs-snapshot-common emacs-snapshot-bin-common emacs-snapshot \
        emacs-snapshot-el emacs-snapshot-gtk emacs23 emacs23-bin-common emacs23-common \
        emacs23-el emacs23-nox emacs23-lucid auctex emacs24 emacs24-bin-common emacs24-common emacs24-common-non-dfsg

    sudo add-apt-repository ppa:cassou/emacs
    sudo apt-get update
    sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg
fi

if [ ! -d ~/.emacs.d ];then
    git clone https://github.com/overtone/emacs-live.git ~/.emacs.d
fi