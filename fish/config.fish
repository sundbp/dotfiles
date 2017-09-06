# fish config
# Patrik Sundberg <patrik.sundberg@gmail.com>

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# We want to start gpg-agent before keychain to pass arguments
set WHOAMI (whoami)
set GPG_AGENTS (pgrep -U $WHOAMI gpg-agent |wc -l)
if [ $GPG_AGENTS -ne 1 ]
  if test (uname) = "Darwin"
    eval (/usr/local/MacGPG2/bin/gpg-agent --daemon --allow-preset-passphrase --write-env-file {$HOME}/.gpg-agent-info)
  end
else
  test -e {$HOME}/.gpg-agent-info ; and posix-source {$HOME}/.gpg-agent-info
end

if status --is-interactive
  keychain --eval --quiet -Q id_rsa | source
end

# direnv
eval (direnv hook fish)

set -x CLICOLOR 1

# http proxy stuff
set -x NO_PROXY "localhost,127.0.0.1"
set -x no_proxy $NO_PROXY

if test (uname) = "Darwin"
  set -x MANPATH /usr/local/share/man $MANPATH
  set -x PATH (brew --prefix coreutils)/libexec/gnubin /usr/local/bin $PATH
  source (brew --prefix)/etc/grc.fish
end

# stray UBUNTU_MENUPROXY
set -e UBUNTU_MENUPROXY

# turn off XON/XOFF
if [ -f /bin/stty ]
  stty -ixon
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

set -x LESS "-R -X"

abbr -a f fuck
abbr -a ll 'exa -abghl --git --color=always'
abbr -a la 'exa -abghl --git --color=automatic'
abbr -a c 'pygmentize -O style=monokai -f console256 -g'
abbr -a more less
abbr -a d docker
abbr -a emacs-app 'open -a /Applications/Emacs.app'
abbr -a fgrep 'fgrep --color=auto'
abbr -a egrep 'egrep --color=auto'
abbr -a loc-clj 'find . -name "*.clj"  -print0 | xargs -0 wc -l'
abbr -a loc-cljs 'find . -name "*.cljs"  -print0 | xargs -0 wc -l'
abbr -a loc-clj-src 'find src/ -name "*.clj"  -print0 | xargs -0 wc -l'
abbr -a loc-cljs-src 'find src/ -name "*.cljs"  -print0 | xargs -0 wc -l'
abbr -a jj-tmux 'mosh jj -- tmux a'
abbr -a jj-tmux-new 'mosh jj -- tmux'
abbr -a ronald-tmux 'mosh ronald -- tmux a'
abbr -a ronald-tmux-new 'mosh ronald -- tmux'
abbr -a java7_switch 'set -x JAVA_HOME (/usr/libexec/java_home -v 1.7)'
abbr -a java8_switch 'set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)'
abbr -a grep 'grep --color=auto'
