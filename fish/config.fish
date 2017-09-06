# fish config
# Patrik Sundberg <patrik.sundberg@gmail.com>

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# We want to start gpg-agent before keychain to pass arguments
set WHOAMI (whoami)
set GPG_AGENTS (pgrep -U $WHOAMI gpg-agent |wc -l)
if [ $GPG_AGENTS -ne 1 ]
  if [ (uname) == "Darwin" ]
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

set -x LESS "-R"
