#!/usr/bin/env bash

# Patrik Sundberg <patrik.sundberg@gmail.com>
#
# This sets up my dot files.

if [[ "$1" != "-f" ]];then
    read -p "This DELETES your current dot files. Are you sure you want to proceed? [y or n]" -n 1 -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo "Skipping install.."
        exit
    fi
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# bash
rm -f ~/.profile
rm ~/.bash_profile
rm ~/.bashrc
rm ~/.bash_completion.d
rm ~/.bash_ssh_agent_funcs.sh
ln -s $DIR/bash_profile ~/.bash_profile
ln -s $DIR/bashrc ~/.bashrc
ln -s $DIR/bash_completion.d ~/.bash_completion.d
ln -s $DIR/bash_ssh_agent_funcs.sh ~/.bash_ssh_agent_funcs.sh

# zsh
if [[ ! -d $HOME/.oh-my-zsh ]];then
    curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
fi
rm ~/.zprofile ~/.zshrc
ln -s $DIR/zprofile ~/.zprofile
ln -s $DIR/zshrc ~/.zshrc

# fish
rm ~/.config/fish
mkdir -p ~/.config
ln -s $DIR/fish ~/.config/fish
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
rm ~/.config/fish/functions/fzf_key_bindings.fish
if [ `uname` == "Linux" ];then
    ln -s ~/.fzf/shell/key-bindings.fish ~/.config/fish/functions/fzf_key_bindings.fish
else
    ln -s /usr/local/Cellar/fzf/0.17.0/shell/key-bindings.fish ~/.config/fish/functions/fzf_key_bindings.fish
fi

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

rm -rf ~/.emacs.d
cd ~
git clone https://github.com/syl20bnr/spacemacs .emacs.d
cd .emacs.d && git checkout develop
cd $DIR
rm ~/.spacemacs
ln -s $DIR/spacemacs/.spacemacs ~/.spacemacs

rm ~/.ssh/config
ln -s $DIR/ssh/config ~/.ssh/

if [ `uname` == "Linux" ];then
    # No X setup for now
    #rm ~/.xsession
    #rm ~/.xsessionrc
    #xsessionfile="xsession.$(hostname)"
    #ln -s $DIR/$xsessionfile ~/.xsession
    #ln -s ~/.xsession ~/.xsessionrc

    #rm ~/.Xdefaults
    #ln -s $DIR/Xdefaults ~/.Xdefaults

    #rm ~/.i3/config
    #mkdir -p ~/.i3
    #i3configfile="i3config.$(hostname)"
    #ln -s $DIR/$i3configfile ~/.i3/config

    #rm ~/.i3status.conf
    #ln -s $DIR/i3status.conf ~/.i3status.conf

    rm ~/.fehbg
    ln -s $DIR/fehbg ~/.fehbg

    rm ~/.fonts
    ln -s $DIR/fonts ~/.fonts
    if [ -f /usr/bin/fc-cache ];then
        fc-cache -vf
    fi
fi

rm -f ~/pictures
ln -s $DIR/pictures ~/pictures

# LightTable
if [ `uname` == "Darwin" ];then
    rm ~/Library/Application\ Support/LightTable/settings/user.keymap
    rm ~/Library/Application\ Support/LightTable/settings/user.behaviors
    ln -s $DIR/lt/user.keymap ~/Library/Application\ Support/LightTable/settings/user.keymap
    ln -s $DIR/lt/user.behaviors ~/Library/Application\ Support/LightTable/settings/user.behaviors
fi

# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

echo ""
echo "Setup of your dot files completed!"
