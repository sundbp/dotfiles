#!/bin/bash

if [ "$(uname)" == "Linux" -a ! -e /usr/bin/vim ];then
    sudo apt-get update
    sudo apt-get install vim
fi

if [ ! -d ~/.vim ];then
    cd ~
    curl -Lo- https://bit.ly/janus-bootstrap | bash
fi
