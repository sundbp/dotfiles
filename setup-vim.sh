#!/bin/bash

if [ ! -d ~/.vim ];then
    cd ~
    curl -Lo- https://bit.ly/janus-bootstrap | bash
fi
