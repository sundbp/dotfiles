# @2012 Patrik Sundberg

# start the ssh-agent
SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}

# test for identities
function test_identities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}

# only bother with ssh agent in interactive sessions
if [ "$TERM" = "rxvt-unicode-256color" ];then
  # check for running ssh-agent with proper $SSH_AGENT_PID
  if [ -n "$SSH_AGENT_PID" ]; then
      ps ux | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
      if [ $? -eq 0 ]; then
        test_identities
      fi
  # if $SSH_AGENT_PID is not properly set, we might be able to load one from
  # $SSH_ENV
  else
      if [ -f "$SSH_ENV" ]; then
        . "$SSH_ENV" > /dev/null
      fi
      ps ux | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
      if [ $? -eq 0 ]; then
          test_identities
      else
          if [ `hostname` != "ronald" ]; then
            start_agent
          fi
      fi
  fi
fi

# let's source the bashrc at end of login
if [ -e ~/.bashrc ]; then
  source ~/.bashrc
fi
