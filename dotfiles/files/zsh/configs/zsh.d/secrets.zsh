# Secret secret!

if [[ `uname` == 'Darwin' ]]; then
    export SUDOPWD="$(getpass -s root)"

    #Required for OSX Brew OpenSSH
    export SSH_AUTH_SOCK=$(launchctl getenv SSH_AUTH_SOCK)
    HOMEBREW_DIR=/usr/local/homebrew

    export HOMEBREW_GITHUB_API_TOKEN=''
    export HOMEBREW_CASK_OPTS="--appdir=~/Applications --caskroom=/opt/homebrew-cask/Caskroom"
    export HOMEBREW_NO_ANALYTICS=1
fi


