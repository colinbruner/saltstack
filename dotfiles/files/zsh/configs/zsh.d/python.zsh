# python.zsh

if [[ -x $(which virtualenvwrapper.sh) ]]; then
    source $(which virtualenvwrapper.sh)
fi

export VIRTUAL_ENV_DISABLE_PROMPT=true 

# Virtualenv Aliases
alias v='workon'
alias v.deactivate='deactivate'
alias v.mk='mkvirtualenv -p python3'
alias v.mk2='mkvirtualenv -p python2'
# v.mk3 is in ~/.bin# Python3
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'

alias py='ipython'
alias py2='ipython2'

# Source poetry build tool
if [[ -d $HOME/.poetry/bin ]]; then
    export PATH="$PATH:$HOME/.poetry/bin"
fi

