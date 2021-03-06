# fish config
# Patrik Sundberg <patrik.sundberg@gmail.com>

if test -z $INSIDE_EMACS
  test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
end

if not test -z $RUNNING_IN_TB
  # we set the terminal explicitly when running in my toolbox
  set -gx TERM xterm-256color
end

# We want to start gpg-agent before keychain to pass arguments
#set WHOAMI (whoami)
#set GPG_AGENTS (pgrep -U $WHOAMI gpg-agent |wc -l)
#if test (uname) = "Darwin"
#  set -x GPG_TTY (tty)
#  set -x SSH_AUTH_SOCK ~/.gnupg/S.gpg-agent.ssh
#  if [ $GPG_AGENTS -ne 1 ]
#    gpgconf --launch gpg-agent
#  end
#  echo "UPDATESTARTUPTTY" | gpg-connect-agent > /dev/null 2>&1
#  set -x USING_GPG_AGENT 1
#end

if test -z $USING_GPG_AGENT
    if status --is-interactive
        if test -z "$SSH_AUTH_SOCK"
            set -l result (keychain --quiet --eval ~/.ssh/id_rsa ~/.ssh/long_key)
            if test $status -eq 0
                eval $result
            end
        end
    end
    begin
        set -l HOSTNAME (hostname)
        if test -z "$SSH_AUTH_SOCK"; and test -f ~/.keychain/$HOSTNAME-fish
            source ~/.keychain/$HOSTNAME-fish
        end
    end
end

if status --is-interactive
  if test 0 -eq (ssh-add -l | grep id_rsa | wc -l)
    ssh-add ~/.ssh/id_rsa
  end
  if test 0 -eq (ssh-add -l | grep long_key | wc -l)
    ssh-add ~/.ssh/long_key
  end
end

# direnv
eval (direnv hook fish)

set -x CLICOLOR 1

# http proxy stuff
set -x NO_PROXY "localhost,127.0.0.1"
set -x no_proxy $NO_PROXY

if test (uname) = "Darwin"
  set -x MANPATH /usr/local/share/man $MANPATH
  set -x PATH (brew --prefix coreutils)/libexec/gnubin /usr/local/bin $HOME/go/bin $PATH
  source (brew --prefix)/etc/grc.fish
  set -x HOMEBREW_INSTALL_CLEANUP true
end

# stray UBUNTU_MENUPROXY
set -e UBUNTU_MENUPROXY

if not test -z $INSIDE_EMACS
    # turn off XON/XOFF
    if [ -f /bin/stty ]
        stty -ixon
    end
end


if [ -d ~/bin ]
  set -x PATH $PATH $HOME/bin
end

set -x LANG 'en_US.UTF-8'
set -x LANGUAGE 'en_US:en'

set -x GPG_TTY (tty)

set -x BOOT_JVM_OPTIONS "-client -XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xmx2g -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled"

if test (uname) = "Darwin"
  source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'
end

if test $TERM = xterm-kitty
    kitty + complete setup fish | source
end

set -x LESS "-R -X"

alias ll='exa -abghl --git --color=always'
alias la='exa -abghl --git --color=automatic'
alias c='pygmentize -O style=monokai -f console256 -g'
alias more='less'
alias d='docker'
alias emacs-app='open -a /Applications/Emacs.app'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias loc-clj='find . -name "*.clj"  -print0 | xargs -0 wc -l'
alias loc-cljs='find . -name "*.cljs"  -print0 | xargs -0 wc -l'
alias loc-clj-src='find src/ -name "*.clj"  -print0 | xargs -0 wc -l'
alias loc-cljs-src='find src/ -name "*.cljs"  -print0 | xargs -0 wc -l'
alias jj-tmux='mosh jj -- tmux a'
alias jj-tmux-new='mosh jj -- tmux'
alias ronald-tmux='mosh ronald -- tmux a'
alias ronald-tmux-new='mosh ronald -- tmux'
alias java7-switch='set -x JAVA_HOME (/usr/libexec/java_home -v 1.7)'
alias java8-switch='set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)'
alias java9-switch='set -x JAVA_HOME (/usr/libexec/java_home -v 9)'
alias java10-switch='set -x JAVA_HOME (/usr/libexec/java_home -v 10)'
alias grep='grep --color=auto'
alias pf='permafrost'
alias e='emacsclient'
alias k='kubectl'
alias kssh='kitty +kitten ssh'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish
