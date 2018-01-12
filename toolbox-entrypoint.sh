#!/bin/bash
if [[ ! -z "$TB_SETUP_AGENT_FWD" ]];then
    echo "Setting up agent forwarding via socat.."
    rm -f $SSH_AUTH_SOCK
    socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork TCP:docker.for.mac.localhost:24125
else
    while [[ true ]];do
        echo "Dummy infinite loop.."
        sleep 120
    done
fi
