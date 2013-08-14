# @2012 Patrik Sundberg

# We want to start gpg-agent before keychain to pass arguments
gpg-agent 2> /dev/null
GPG_RUNNING=$?
if [ $GPG_RUNNING -ne 0 ];then
   eval $(gpg-agent --daemon --allow-preset-passphrase --write-env-file "${HOME}/.gpg-agent-info")
else
   . "${HOME}/.gpg-agent-info"
   export GPG_AGENT_INFO
fi

eval `keychain --eval --inherit any id_rsa`

# let's source the bashrc at end of login
if [ -e ~/.bashrc ]; then
  source ~/.bashrc
fi
