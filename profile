# MacPorts Installer addition on 2009-09-27_at_12:58:44: adding an appropriate PATH variable for use with MacPorts.
if [ `hostname` = "radiac" ]; then
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=/opt/local/share/man:/usr/local/share/man:$MANPATH
fi
# Finished adapting your PATH environment variable for use with MacPorts.

if [ `hostname` = "bob" ]; then
  export PATH=$PATH:/var/lib/gems/1.8/bin
fi

if [ `hostname` = "lnpsprod1" ]; then
  export PATH=/home/psundberg/user-root/bin:/home/psundberg/user-root/jruby-1.4.0/bin:/home/psundberg/user-root/jdk1.6.0_17/bin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin:/usr/local/bin:/usr/local/X11
  export JAVA_HOME=/home/psundberg/user-root/jdk1.6.0_17
fi

source $HOME/.bash_completion.d/git-completion.bash

#export LSCOLORS=gxfxcxdxbxegedabagacad
export EDITOR="vim"
alias ls="ls -lGF"
alias ri="ri -Tf ansi"
alias more="less"

export CLICOLOR_FORCE=yes

scm_ps1() {
  local s=
  if [[ -d ".svn" ]] ; then
    s=\(svn\)
  else
    s=$(__git_ps1 "(git:%s)")
  fi
  echo -n "$s"
}
export PS1="\[\033[00;32m\]\u\[\033[00;32m\]@\[\033[00;32m\]\h:\[\033[01;34m\]\w \[\033[31m\]\$(scm_ps1)\[\033[00m\]$\[\033[00m\] "
 
#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND='echo -ne "\033]0;bash\007"'

export LESS="-R"
