# login.zsh

##################
## Login Scripts #
##################
# Automatically start SSH Agent on boot when no previous .agent.env file is found
if [ -f ~/.agent.env ] ; then
    . ~/.agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        echo "Stale agent file found. Spawning new agent… "
        eval `ssh-agent | tee ~/.agent.env`
        ssh-add
        for key in $HOME/.ssh/*; do if [[ $key != *"pub" ]] && [[ $key == *"id_"* ]]; then ssh-add $key; fi; done
    fi
else
    echo "Starting ssh-agent"
    eval `ssh-agent | tee ~/.agent.env`
    ssh-add
    for key in $HOME/.ssh/*; do if [[ $key != *"pub" ]] && [[ $key == *"id_"* ]]; then ssh-add $key; fi; done
fi
