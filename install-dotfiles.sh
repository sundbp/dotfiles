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
rm -f ~/.profile
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

rm ~/bin
ln -s $DIR/bin ~/bin

rm ~/.aprc
ln -s $DIR/aprc ~/.aprc

rm ~/.lein
ln -s $DIR/lein ~/.lein

rm ~/.emacs-live.el
ln -s $DIR/emacs-live.el ~/.emacs-live.el

rm ~/.live-packs
ln -s $DIR/live-packs ~/.live-packs

rm ~/.ssh/config
ln -s $DIR/ssh/config ~/.ssh/

if [ `uname` == "Linux" ];then
  rm ~/.xsession
  # use default file for a few, and special ones for others
  ln -s xsession xsession.nt51p9393
  ln -s xsession xsession.ronald
  ln -s xsession xsession.sundbp-N120
  xsessionfile="xsession.$(hostname)"
  ln -s $DIR/$xsessionfile ~/.xsession

  rm ~/.Xdefaults
  ln -s $DIR/Xdefaults ~/.Xdefaults

  rm ~/.i3/config
  mkdir -p ~/.i3
  i3configfile="i3config.$(hostname)"
  ln -s $DIR/$i3configfile ~/.i3/config

  rm ~/.i3status.conf
  ln -s $DIR/i3status.conf ~/.i3status.conf

  rm ~/.fehbg
  ln -s $DIR/fehbg ~/.fehbg

  rm ~/.fonts
  ln -s $DIR/fonts ~/.fonts
  fc-cache -vf
fi

if [ `uname` == "Darwin" ];then
  rm ~/Library/Preferences/com.googlecode.iterm2.plist
  ln -s $DIR/com.googlecode.iterm2.plist ~/Library/Preferences/
fi

echo ""
echo "Setup of your dot files completed!"
