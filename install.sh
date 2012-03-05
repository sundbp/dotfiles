#!/usr/bin/env bash

# @2012 Patrik Sundberg
#
# This sets up my dot files.

read -p "This DELETES your current dot files. Are you sure you want to proceed? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# bash
rm ~/.bash_profile
rm ~/.bashrc
rm -r ~/.bash_completion.d
ln -s $DIR/bash_profile ~/.bash_profile
ln -s $DIR/bashrc ~/.bashrc
ln -s $DIR/bash_completion.d ~/.bash_completion.d

# gemrc
rm ~/.gemrc
ln -s $DIR/gemrc ~/.gemrc

# gitconfig
rm ~/.gitconfig
ln -s $DIR/gitconfig ~/.gitconfig

# tmux
rm -r ~/.tmux
rm ~/.tmux.conf
ln -s $DIR/tmux ~/.tmux
ln -s $DIR/tmux.conf ~/.tmux.conf

# dircolors
rm ~/.dircolors
ln -s $DIR/dircolors ~/.dircolors

# vim and janus

