#!/bin/bash

apt update
apt-get install direnv python3-dev python3-pip rbenv libhttp-parser2.1

pip3 install --upgrade pip

pip3 install thefuck

cd /tmp
EXA_FILE="exa-linux-x86_64-0.7.0.zip"
wget https://the.exa.website/releases/$EXA_FILE
unzip $EXA_FILE
mv exa-linux-x86_64 /usr/local/bin/exa
