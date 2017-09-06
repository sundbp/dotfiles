# Patrik Sundberg <patrik.sundberg@gmail.com>

# We want to start gpg-agent before keychain to pass arguments
WHOAMI=$(whoami)
GPG_AGENTS=$(pgrep -U $WHOAMI gpg-agent |wc -l)
if [ $GPG_AGENTS -ne 1 ];then
   if [ `uname` == "Darwin" ];then
      eval $(/usr/local/MacGPG2/bin/gpg-agent --daemon --allow-preset-passphrase --write-env-file "${HOME}/.gpg-agent-info")
   fi
else
   test -e "$HOME/.gpg-agent-info" && source "${HOME}/.gpg-agent-info"
   export GPG_AGENT_INFO
fi

eval `keychain --eval --inherit any id_rsa`

test -e "${HOME}/.iterm2_shell_integration.bash" && source ~/.iterm2_shell_integration.`basename $SHELL`

#rbenv
eval "$(rbenv init -)"
export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"

. /Users/sundbp/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
