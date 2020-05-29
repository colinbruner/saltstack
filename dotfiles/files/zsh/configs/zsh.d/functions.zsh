# functions.zsh

# General
function random () {
       date |md5 | head -c; echo
}

### GPG Functions for laziness
function gpg_export_pubkey () {
    gpg --output public.key --export colin.d.bruner@gmail.com
}

function gpg_import_pubkey () {
    echo "Importing $1"
    gpg --import $1
}

function gpg_export_privkey () {
    gpg --output private.key --export-secret-subkeys colin.d.bruner@gmail.com
}

function gpg_import_privkey () {
    echo "Importing $1"
    gpg --allow-secret-key-import --import $1
}

function gpg_print_pubkey () {
    gpg --armor --export colin.d.bruner@gmail.com | tee pubkey.asc
    echo
    echo "Saved output as `pwd`/pubkey.asc"

}

# Determine size of a file or total size of a directory
function fs() {
if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh;
else
    local arg=-sh;
fi
if [[ -n "$@" ]]; then
    du $arg -- "$@";
else
    du $arg .[^.]* ./*;
fi;
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript;
else # pipe
    python -mjson.tool | pygmentize -l javascript;
fi;
}

# Run `dig` and display the most useful info
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer;
}

# `o` with no arguments opens the current directory, 
# otherwise opens the given location
function o() {
if [ $# -eq 0 ]; then
    open .;
else
    open "$@";
fi;
}

function serve {
    port=${1:-8080}
    (ifconfig | grep -E 'inet.[0-9]' | grep -v -E '127.0.0.1|-->' | awk '{ printf $2}';echo ":$port") | pbcopy
    echo "URL copied to clipboard."
    python -m SimpleHTTPServer $port
}

function proxy_ssh {
    # https://calomel.org/firefox_ssh_proxy.html
    # opens a proxy tunnel at local 8443 to rhome ssh alias. Requires socks5 local browser configuration (firefox)
    ssh -C2qTnN -D 8443 rhome
}

function forward_ssh {
    TARGET=$1
    PROXY=$2
    PORT="$3"

    if [[ -z $TARGET ]] || [[ -z $PROXY ]] || [[ -z $PORT ]]; then
        echo "Usage: $0 <target> <proxy> <port>"
        echo "$ forward_ssh remote_webserver1 random_jumphost2 8080"
        return
    fi

    echo "OPEN YOUR BROWSER TO https://localhost:$PORT"
    # chrome://flags/#allow-insecure-localhost -- to shut chrome up
    ssh -L$PORT:$TARGET:$PORT $PROXY
}

# Generic getpass, overwritten by work specific if work.zsh is sourced
function getpass() {
    if [ -z "$1" ]; then
        echo "Usage: $0 [-s] <account>"
        return
    fi

    if [[ "$1" == '-s' ]] && [ ! -z "$2" ]; then
        security find-generic-password -s $2 -w | tr -d '\n'
    elif [ -z "$2" ]; then
        echo "Adding password for $1 to clipboard"
        security find-generic-password -s $1 -w | tr -d '\n' | pbcopy
    fi
}

# Update zsh_plugins file
function update_zsh_plugins() {
    if [[ -x $(which antibody) ]] && [[ -f $HOME/.zsh_plugins.txt ]]; then
        antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
    else
	echo "Missing either antibody binary or $HOME/.zsh_plugins.txt file."
        return 1
    fi
}


function tcpdump_flags(){
    # Usage: Print out tcpdump flag counts in 1000 queries
    # Example:
    # tcpdump -c1000 -nnei any "host IP" | egrep -o 'Flags.*?,' | cut -d, -f1 | sort | uniq -c
    tcpdump -c1000 -nnei any "host $1" | egrep -o 'Flags.*?,' | cut -d, -f1 | sort | uniq -c
}

# Start Docker Functions
function clean_docker_images () {
    # Clean dangling or "untagged" images
    docker rmi $(docker images -f "dangling=true" -q)
}

function rcmd () {
    #Works fine for CLI, poorly for scripting. Need an actual file
    ConnectTimeout=3

    HOSTNAME=$1; shift
    if [[ "$HOSTNAME" == "-i" ]]; then
        HOSTNAME=$1
        shift
        echo "Hostname: $HOSTNAME"
    fi
    RUSER=$1; shift
    RCMD=$*

    if [[ "$HOSTNAME" == "" ]] || [[ $RUSER == "" ]] || [[ $RCMD = "" ]];
    then
        echo "error: $0 [-i] <hostname> <user> <command> (<args>)"
        return 1
    fi

    if [[ "$SUDOPWD" == "" ]]; then
        read -s -p "SUDO Password: " SUDOPWD
        echo
    fi
    export SUDOPWD

    echo $SUDOPWD | ssh -o ConnectTimeout=$ConnectTimeout $HOSTNAME "export TERM=vt100; export PATH=$PATH:/usr/bin:/usr/sbin:/usr/local/sbin:/usr/local/bin; sudo -S -p '' su - $RUSER -c '$RCMD'" | egrep -v '^###|Hello there'
    return $?
}

# https://babushk.in/posts/renew-environment-tmux.html
if [ -n "$TMUX" ]; then                                                                               
  function refresh {                                                                                
    export $(tmux show-environment | grep "^SSH_AUTH_SOCK")                                       
    export $(tmux show-environment | grep "^DISPLAY")                                             
  }                                                                                                 
else                                                                                                  
  function refresh { }                                                                              
fi

# https://gist.github.com/admackin/4507371
function _ssh_auth_save() {
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-auth-sock.$HOSTNAME"
}
