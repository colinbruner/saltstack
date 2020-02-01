#zplug.zsh

# Check if zplug is installed, install and init if not
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source $HOME/.zplug/init.zsh

#################
# zplug Plugins #
#################

# Let zplug manage zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# Async for zsh, used by pure theme
#zplug "mafredri/zsh-async", from:github, defer:0

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:3

# Load completion library for those sweet [tab] squares
zplug "lib/completion", from:oh-my-zsh
# Up -> History search! Who knew it wasn't a built in?
zplug "lib/key-bindings", from:oh-my-zsh
# History defaults
zplug "lib/history", from:oh-my-zsh
# Adds useful aliases for things dealing with directories
zplug "lib/directories", from:oh-my-zsh

# Load oh-my-zsh Plugins
zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "plugins/osx", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

# Themes
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
#zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
