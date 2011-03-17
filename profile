source $HOME/.bash_completion.d/git-completion.bash

export EDITOR="vim"
alias ls="ls -lF"
alias ri="ri -Tf ansi"
alias more="less"
alias be="bundle exec"
export LESS="-R"

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

my_hostname=`hostname` 
#echo "Starting shell on $my_hostname"

if [ $my_hostname = "radiac.local" ]; then
  #echo "Applying settings specific to radiac.."
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  export MANPATH=/opt/local/share/man:/usr/local/share/man:$MANPATH
  export LSCOLORS=gxfxcxdxbxegedabagacad
  export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'
  export PROMPT_COMMAND='echo -ne "\033]0;bash\007"'
fi

if [ $my_hostname = "bob" ]; then
  #echo "Applying settings specific to bob.."
  export PATH=$PATH:/var/lib/gems/1.8/bin
fi

if [ $my_hostname = "lnpsprod1" ]; then
  #echo "Applying settings specific to lnpsprod1.."
  export PATH=/dat/schurman/user-root/opt/ruby191/bin:/dat/schurman/user-root/bin:/dat/schurman/user-root/jdk1.6.0_17/bin:/dat/schurman/user-root/apache-ant-1.7.0/bin:/dat/schurman/user-root/apache2/bin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/X11R6/bin:/usr/local/bin:/usr/local/X11
  export MANPATH=/dat/schurman/user-root/share/man:$MANPATH
  export JAVA_HOME=/dat/schurman/user-root/jdk1.6.0_17
  export ANT_HOME=/dat/schurman/user-root/apache-ant-1.7.0
  export PGDATA=/dat/schurman/user-root/pgsql/data
  eval `keychain -q --eval --agents ssh id_rsa`
  if [[ -s $HOME/.rvm/scripts/rvm ]]; then
    source $HOME/.rvm/scripts/rvm
  fi
  umask 0002
fi

if [ ${my_hostname:0:8} = "LNWTR074" -o ${my_hostname:0:8} = "LNWTR033" ]; then
  #echo "Applying settings specific to lnwtr074.."
  my_hostname=${my_hostname:0:8}
  keychain_script="$HOME/.keychain/$my_hostname-sh"
  export PATH=/bin:$PATH
  export GIT_SSH=/cygdrive/c/Program\ Files/PuTTY/plink.exe
  keychain "$HOME/.ssh/id_rsa"
  source $keychain_script 
fi

if [ $my_hostname = "NT51P9393" -o $my_hostname = "NT51P9342" ]; then
  export http_proxy=$HTTP_PROXY
  export https_proxy=$HTTP_PROXY
  export GIT_SSL_NO_VERIFY=true
  keychain ~/.ssh/id_rsa
  . ~/.keychain/$HOSTNAME-sh
fi

if [ $my_hostname = "pts-vbox" ]; then
  if [[ -s $HOME/.rvm/scripts/rvm ]]; then
    source $HOME/.rvm/scripts/rvm
  fi
fi
