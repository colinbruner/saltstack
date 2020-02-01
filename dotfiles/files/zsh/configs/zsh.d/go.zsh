# go.zsh

if [[ `uname` == 'Darwin' ]]; then
    # Install via homebrew
    export GOROOT="/usr/local/opt/go/libexec"
    export PATH="$PATH:/usr/local/opt/go/bin"
elif [ -d "/usr/local/go" ]; then
    export GOROOT="/usr/local/go"
    export PATH="$PATH:/usr/local/go/bin"
else 
    export GOROOT="/app/go/"
fi

if [[ $(hostname) == *"RES"* ]] && [ -d "$HOME/go" ]; then 
    export GOPATH="$HOME/go"
    export GOWORK="$GOPATH/src/github.com/colinbruner"
    export GOBIN="$GOPATH/bin"
    export PATH="$PATH:$GOBIN"
elif [ -d "$HOME/go" ]; then
    export GOPATH="$HOME/go"
    export GOWORK="$GOPATH/src/github.com/colinbruner"
    export GOBIN="$GOPATH/bin"
    export PATH="$PATH:$GOBIN"
fi 
