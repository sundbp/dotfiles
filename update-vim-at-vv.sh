#!/usr/bin/env bash

# this script copies the vim setup installed on vv to
# dot_files and clears out the .git dirs so we can
# check it in.

rm -rf vim

cp -r ~/.vim vim
cp ~/.vimrc vimrc
cp ~/.gvimrc gvimrc
cp ~/.vimrc.before vimrc.before
cp ~/.vimrc.after vimrc.after

find vim -name .git | xargs rm -rf
