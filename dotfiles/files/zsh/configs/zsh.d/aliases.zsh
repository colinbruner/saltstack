# alises.zsh

###########
# Aliases #
###########

# Git
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpu='git pull'
alias gb='git branch'
alias gco='git checkout'

# vim
alias vi=$(which vim)
if [[ -x $(which nvim) ]]; then
    alias vi=$(which nvim)
    alias vim=$(which nvim)
fi

# fix tmux colors
#alias tmux="env TERM=xterm-256color tmux"
alias tmux='tmux -2'

# copy pubkey
alias pubkey="cat ~/.ssh/id_rsa_personal.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# util
alias grepnc='grep -v "^$\|^#"'
alias startssh='eval `ssh-agent -s` && ssh-add'

# https://gist.github.com/admackin/4507371
alias screen='_ssh_auth_save ; export HOSTNAME=$(hostname) ; screen'
alias tmux='_ssh_auth_save ; export HOSTNAME=$(hostname) ; tmux'
#alias tmux="TERM=screen-256color-bce tmux"
