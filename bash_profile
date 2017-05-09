# @2012 Patrik Sundberg

# We want to start gpg-agent before keychain to pass arguments
WHOAMI=$(whoami)
GPG_AGENTS=$(pgrep -U $WHOAMI gpg-agent |wc -l)
if [ $GPG_AGENTS -ne 1 ];then
   eval $(/usr/local/MacGPG2/bin/gpg-agent --daemon --allow-preset-passphrase --write-env-file "${HOME}/.gpg-agent-info")
else
   . "${HOME}/.gpg-agent-info"
   export GPG_AGENT_INFO
fi

eval `keychain --eval --inherit any id_rsa`

# let's source the bashrc at end of login
if [ -e ~/.bashrc ]; then
  source ~/.bashrc
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
