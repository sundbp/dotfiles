#!/usr/bin/env bash

# this script copies the vim setup installed on vv to
# dot_files and clears out the .git dirs so we can
# check it in.

rm -rf vim

cp -r ~/.vim vim

find vim -name .git | xargs rm -rf
find vim -name .gitignore | xargs rm -rf
