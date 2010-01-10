my_hostname=`hostname` 
#echo "Starting shell on $my_hostname"

if [ $my_hostname = "radiac" ]; then
  #echo "Applying settings specific to radiac.."
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=/opt/local/share/man:/usr/local/share/man:$MANPATH
fi

if [ $my_hostname = "bob" ]; then
  #echo "Applying settings specific to bob.."
  export PATH=$PATH:/var/lib/gems/1.8/bin
fi

if [ $my_hostname = "lnpsprod1" ]; then
  #echo "Applying settings specific to lnpsprod1.."
  export PATH=/home/psundberg/user-root/bin:/home/psundberg/user-root/jruby-1.4.0/bin:/home/psundberg/user-root/jdk1.6.0_17/bin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin:/usr/local/bin:/usr/local/X11
  export JAVA_HOME=/home/psundberg/user-root/jdk1.6.0_17
  eval `keychain -q --eval --agents ssh id_rsa`
  if [[ -s /home/psundberg/.rvm/scripts/rvm ]]; then
    source /home/psundberg/.rvm/scripts/rvm
  fi
fi

if [ $my_hostname = "LNWTR074" ]; then
  #echo "Applying settings specific to lnwtr074.."
  export PATH=$PATH:/bin
  export GIT_SSH=/cygdrive/c/Program\ Files/PuTTY/plink.exe
  keychain .ssh/id_rsa
  source .keychain/LNWTR074-sh
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
