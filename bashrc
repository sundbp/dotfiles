# @2012 Patrik Sundberg

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export CLICOLOR=1

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi
if [ -x /usr/local/bin/gdircolors ]; then
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
    alias ls='gls --color=auto'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias tmux="tmux -2"
alias rr="rbenv rehash"
alias cgrep="grep --color=always"
export EDITOR="vim -f"

alias e='emacs -nw'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# bash completion
source ~/.bash_completion.d/git-completion.bash

# prompt
scm_ps1() {
    local s=
    if [[ -d ".svn" ]] ; then
        s=\(svn\)
    else
        s=$(__git_ps1 "(git:%s)")
    fi
    echo -n "$s"
}
if [ "$TERM" = "linux" ] || [ "$TERM" = "eterm-color" ];then
    export PS1="\[\033[00;36m\]\u\[\033[00;36m\]@\[\033[00;36m\]\h:\[\033[00;34m\]\w \[\033[0;33m\]\$(scm_ps1)\[\033[00m\]$\[\033[00m\] "
else
    export PS1="\[\033]0;\u@\h:\w\007\]\[\033[00;36m\]\u\[\033[00;36m\]@\[\033[00;36m\]\h:\[\033[00;34m\]\w \[\033[0;33m\]\$(scm_ps1)\[\033[00m\]$\[\033[00m\] "
fi

export PS1="\[\033[G\]$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# node.js stuff
if [ -f ~/.nvm/nvm.sh ]; then
    source ~/.nvm/nvm.sh
fi

# http proxy stuff
export NO_PROXY=localhost,127.0.0.1
export no_proxy=$NO_PROXY

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

if [ `uname` == "Darwin" ];then
    export MANPATH=/usr/local/share/man:$MANPATH
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
    source "`brew --prefix`/etc/grc.bashrc"
fi

# vpn related - SNX messes up resolv.conf
alias fix-resolvconf='sudo rm /etc/resolv.conf && echo "nameserver 127.0.0.1" > /tmp/rconf && echo "search glennt.london.glencore.com" >> /tmp/rconf && sudo cp /tmp/rconf /etc/resolv.conf'
alias connect-vpn-glencore='snx && fix_resolvconf'

# TERM
if [ "$TERM" == "xterm" -a `hostname` == 'ronald' ]; then
    # No it isn't, it's gnome-terminal
    export TERM=xterm-256color
fi

# stray UBUNTU_MENUPROXY
unset UBUNTU_MENUPROXY

# turn off XON/XOFF
if [ -f /bin/stty ];then
    stty -ixon
fi

#export RBX_ROOT=$HOME/.rbenv/versions/rbx-2.0.0-dev

# path related bits at the end here
if [ -d ~/.rbenv ];then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

if [ -d ~/bin ];then
    export PATH="$PATH:$HOME/bin"
fi

export PATH="./b:$PATH"

export LANG=en_US.UTF-8
export LANGUAGE="en_US:en"

# autocorrect cd spelling mistakes
shopt -s cdspell

# clojure LOC counter
alias loc-clj='find . -name "*.clj"  -print0 | xargs -0 wc -l'

# lsof helpers
alias lsof-offenders="lsof | awk '{ print \$1; }' | uniq -c | sort -rn | head"

GPG_TTY=$(tty)
export GPG_TTY

if [ -f /usr/local/share/chruby/chruby.sh ];then
    source /usr/local/share/chruby/chruby.sh
    chruby jruby-1.7.4
fi

# marks
export MARKPATH=$HOME/.marks
mkdir -p $MARKPATH
function j {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}

if [ `uname` == "Darwin" ];then
    function marks {
        \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
    }
    find="gfind"
else
    function marks {
        ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
    }
    find="find"
fi

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$($find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks j unmark

# use our own showterm server
export SHOWTERM_SERVER=http://showterm.vlan.tuloscapital.com/
