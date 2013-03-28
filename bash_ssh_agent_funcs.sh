#!/bin/bash
#
# start the ssh-agent
HOSTNAME=`hostname`
SSH_ENV="$HOME/.ssh/$HOSTNAME-environment"

# start the ssh-agent
function start_ssh_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    . "$SSH_ENV" > /dev/null
    ssh-add
}

# test for identities
function test_ssh_agent_entities {
    # test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_ssh_agent
        fi
    fi
}

function setup_ssh_agent_env {
  # check for running ssh-agent with proper $SSH_AGENT_PID
  if [ -n "$SSH_AGENT_PID" ]; then
      ps ux | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
      if [ $? -eq 0 ]; then
        test_ssh_agent_entities
      fi
  # if $SSH_AGENT_PID is not properly set, we might be able to load one from
  # $SSH_ENV
  else
      if [ -f "$SSH_ENV" ]; then
        . "$SSH_ENV" > /dev/null
      fi
      ps ux | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
      if [ $? -eq 0 ]; then
          test_ssh_agent_entities
      else
          if [ `hostname` != "ronald" ]; then
            start_ssh_agent
          fi
      fi
  fi
}
