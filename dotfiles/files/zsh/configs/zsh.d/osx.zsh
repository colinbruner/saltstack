# Linux like file colors
export LSCOLORS=ExFxBxDxCxegedabagacad

# Enable CLI Colors
export CLICOLOR=1

# So I can use an up-to-date version of python, installed by brew, and not system standard
export PYTHONPATH='/usr/local/bin/python'

# X11 Forwarding Requirements
export DISPLAY=":0"
export X11_PREFS_DOMAIN="org.macosforge.xquartz.X11"

# iTerm Stuff
[[ -e $HOME/.iterm2_shell_integration.zsh ]] && source $HOME/.iterm2_shell_integration.zsh
