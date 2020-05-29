# antigen.sh

# Load oh-my-zsh library, when it doesn't exist
antigen use oh-my-zsh

# Load oh-my-zsh Plugins
antigen bundle robbyrussell/oh-my-zsh plugins/git
antigen bundle robbyrussell/oh-my-zsh plugins/pip
antigen bundle robbyrussell/oh-my-zsh plugins/osx
antigen bundle robbyrussell/oh-my-zsh plugins/osx

# Local oh-my-zsh libs
antigen bundle robbyrussell/oh-my-zsh lib/completion
antigen bundle robbyrussell/oh-my-zsh lib/key-bindings
antigen bundle robbyrussell/oh-my-zsh lib/history
antigen bundle robbyrussell/oh-my-zsh lib/directories

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# Apply
antigen apply
