if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# MacPorts Installer addition on 2009-09-27_at_12:58:44: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#export LSCOLORS=gxfxcxdxbxegedabagacad
export EDITOR="vim"
alias ls="ls -lGF"
alias ri="ri -Tf ansi"
alias more="less"

export CLICOLOR_FORCE=yes
export MANPATH=/opt/local/share/man:/usr/local/share/man:$MANPATH

scm_ps1() {
    local s=
    if [[ -d ".svn" ]] ; then
        s=\(svn\)
    else
	if which git-completion.bash >/dev/null; then # Only show if compleation is there
          s=$(__git_ps1 "(git:%s)")
        fi
    fi
    echo -n "$s"
}
export PS1="\[\033[00;32m\]\u\[\033[00;32m\]@\[\033[00;32m\]\h:\[\033[01;34m\]\w \[\033[31m\]\$(scm_ps1)\[\033[00m\]$\[\033[00m\] "
 
#export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND='echo -ne "\033]0;bash\007"'

export LESS="-R"
