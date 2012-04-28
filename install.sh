#!/usr/bin/env bash

# @2012 Patrik Sundberg
#
# This sets up my dot files.

read -p "This DELETES your current dot files. Are you sure you want to proceed? [y or n]" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  echo "Skipping install.."
  exit
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# bash
rm ~/.profile
rm ~/.bash_profile
rm ~/.bashrc
rm ~/.bash_completion.d
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
rm ~/.tmux
rm ~/.tmux.conf
ln -s $DIR/tmux ~/.tmux
ln -s $DIR/tmux.conf ~/.tmux.conf

# dircolors
rm ~/.dircolors
ln -s $DIR/dircolors ~/.dircolors

# vim and janus
if [ ! `hostname -f` = "dev.vannavolga.info" ];then
  rm ~/.vim
  rm ~/.vimrc
  rm ~/.gvimrc
  ln -s $DIR/vim ~/.vim
  ln -s $DIR/vim/janus/vim/vimrc ~/.vimrc
  ln -s $DIR/vim/janus/vim/gvimrc ~/.gvimrc
fi
rm ~/.vimrc.before
rm ~/.vimrc.after
ln -s $DIR/vimrc.before ~/.vimrc.before
ln -s $DIR/vimrc.after ~/.vimrc.after
rm ~/.janus
ln -s $DIR/janus ~/.janus

rm ~/.pryrc
ln -s $DIR/pryrc ~/.pryrc

rm ~/.snxrc
ln -s $DIR/snxrc ~/.snxrc

rm ~/.config/rc.lua
ln -s $DIR/rc.lua ~/.config/rc.lua

rm ~/.xsession
ln -s $DIR/xsession ~/.xsession

rm ~/.Xdefaults
ln -s $DIR/Xdefaults ~/.Xdefaults

rm ~/.i3/config
mkdir -p ~/.i3
ln -s $DIR/i3config ~/.i3/config

rm ~/bin
ln -s $DIR/bin ~/bin

echo ""
echo "Setup of your dot files completed!"
