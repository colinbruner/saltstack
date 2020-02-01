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

function ilo_console() {
    # Run like: `ilo_console <ilo ip/hostname>`
    echo "Ensure ILO_USER and ILO_PWD environment variables are set."

    TARGET=$1
    JUMPHOST=${2:-resjump1-brn1}
 
    TMPFILE=`mktemp -t ilostart`
    # Set extension so open works properly below
    mv $TMPFILE "$TMPFILE.jnlp" &>/dev/null
    TMPFILE="$TMPFILE.jnlp"
    #echo $TMPFILE
 
    # Get the latency for the remote connection
    LATENCY=$(printf "%.0f" $( { time -p ssh $JUMPHOST ping -q -c1 $1  >/dev/null; } 2>&1 | head -n1 | cut -d' ' -f2 ))
    SLEEP_TIME=$(($LATENCY + 1))
    echo "Sleeping $SLEEP_TIME seconds to account for latency of $LATENCY seconds"
 
    # This forks a job to the background, referenced as "%%" (last backgrounded job) below by kill
    { ssh -2 -nN -L17988:$1:17988 -L17990:$1:17990 -L8443:$1:8443 -L4443:$1:443 $JUMPHOST & } &>/dev/null
 
    sleep $SLEEP_TIME
    SESSION_CONTENTS=$(curl -XPOST -k -d "{\"method\":\"login\",\"user_login\":\"$ILO_USER\",\"password\":\"$ILO_PWD\"}" https://127.0.0.1:4443/json/login_session 2>/dev/null)
    if [ $? -gt 0 ]; then
        echo "Unable to make a connection to $1 (is it actually an iLO?!)"
        { kill -9 %% && wait; } &>/dev/null
        return
    fi
    ILO_SESS_KEY=$(echo $SESSION_CONTENTS | tr -d '{}"' | tr ',' '\n' | grep session_key | cut -d: -f2)
    if [ ! "$ILO_SESS_KEY" ]; then
        echo "Failed to get sessionkey from $1"
        { kill -9 %% && wait; } &>/dev/null
        return
    fi
 
    # Determine proper jar file
    # Roughly supports ilo version 1.5+
    for jarfile in intgapp4_231.jar intgapp_228.jar intgapp_216.jar; do
        # HEAD is not allowed, must GET...
        curl -ks --fail -XGET https://127.0.0.1:4443/html/$jarfile -o /dev/null || continue
        ILO_JAR_FILE=$jarfile
        break
    done
    if [ ! "$ILO_JAR_FILE" ]; then
        echo "Failed to determine JAR_FILE for $1"
        { kill -9 %% && wait; } &>/dev/null
        return
    fi
    echo "Detected JAR_FILE: $ILO_JAR_FILE"
 
    # Note the ILO_SESS_KEY and ILO_JAR_FILE variables
    cat <<_EOF >$TMPFILE
<?xml version="1.0" encoding="UTF-8"?><jnlp spec="1.0+" codebase="https://127.0.0.1:4443/" href=""><information><title>Integrated Remote Console</title><vendor>HPE</vendor><offline-allowed></offline-allowed></information><security><all-permissions></all-permissions></security><resources><j2se version="1.5+" href="http://java.sun.com/products/autodl/j2se"></j2se><jar href="https://127.0.0.1:4443/html/${ILO_JAR_FILE}" main="false" /></resources><property name="deployment.trace.level property" value="basic"></property><applet-desc main-class="com.hp.ilo2.intgapp.intgapp" name="iLOJIRC" documentbase="https://127.0.0.1:4443/html/java_irc.html" width="1" height="1"><param name="RCINFO1" value="${ILO_SESS_KEY}"/><param name="RCINFOLANG" value="en"/><param name="INFO0" value="7AC3BDEBC9AC64E85734454B53BB73CE"/><param name="INFO1" value="17988"/><param name="INFO2" value="composite"/></applet-desc><update check="background"></update></jnlp>
_EOF
 
    # This is OSX specific...
    open $TMPFILE
 
    echo -n "Please hit enter when completed with the ILO."; read
    echo -n "Terminating SSH Tunnel at PID `jobs -p %%`... "
    { kill -9 %% && wait; } &>/dev/null
    rm -fv $TMPFILE &>/dev/null
    echo "done."
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
