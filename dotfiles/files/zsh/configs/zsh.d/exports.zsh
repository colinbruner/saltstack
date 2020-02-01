#exports.zsh

################
## Application #
################
export LESS='-IRX' # case insenstive search / raw color sequences / don't clear screen on exit
export TERM=screen-256color
if [[ -x $(which nvim) ]]; then
    export EDITOR="nvim"
elif [[ -x $(which vim) ]]; then
    export EDITOR="nvim"
else
    export EDITOR="vi"
fi
export GPGHOME="$HOME/.gnupg"
export GPG_AGENT_INFO="$GPGHOME/S.gpg-agent"
export GPG_TTY="$(tty)"

######################
## Coloured manpages #
######################
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

