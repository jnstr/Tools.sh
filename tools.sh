#!/bin/bash

ROOT_DIR="$(dirname $0)"

bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
yellow=$(tput setaf 2)
clear_color=$(tput sgr0)

# Loop the ROOT_DIR and list all the available commands
# The folders are the namespace name and the file name in that folder
# is the action name
# Actions are always namespaced, and only a single level is supported for now
#
# example:
# do:this will call ROOT_DIR/do/this.sh
function print_available_commands() {
    echo -e "${bold}Available commands"
    echo -e "-------------------------${normal}"

    for f in ~/.tools/* ; do
        if [ -d "$f" ]; then
            print_commands_for_directory $f
        fi
    done
}

function print_commands_for_directory() {
    NAMESPACE_NAME=$(basename $1)
    echo ""
    echo -e "${red}#### $NAMESPACE_NAME ####${normal}"
    for g in $1/*.sh; do
        if [ -f "$g" ]; then
            FILE_NAME=$(basename $g)
            ACTION_NAME="${FILE_NAME%.*}"
            echo -e "${yellow}$NAMESPACE_NAME:$ACTION_NAME${normal}"
            source $g
            echo "        $DESCRIPTION"
        fi
    done
}

# Show available commands if there is no argument set
if [ -z "$1" ]
  then
    echo ""
    print_available_commands
    exit
fi

# Check if we have a folder name
# if so, we show the commands for that folder
if [[ $1 != *":"* ]]; then
    COMMANDS_DIRECTORY="$ROOT_DIR/$1"
    if [ -d $COMMANDS_DIRECTORY ]; then
        print_commands_for_directory $COMMANDS_DIRECTORY
    else
        echo "namespace \"$1\" does not exist"
    fi
    exit;
fi

# Convert the "action" argument to the file name
# example:
# do:this will call ROOT_DIR/do/this.sh
USER_ACTION=${1//:/\/}
FILE_NAME="$ROOT_DIR/$USER_ACTION.sh"


# Prevent errors: only continue if the file actually exists
if [ ! -f $FILE_NAME ]; then
echo "action \"$1\" does not exist"
exit
fi

source $FILE_NAME

# The commands are set in the "performAction" function in the file, so
# this function should be initialized in order to continue
FUNCTION_NAME='performAction'
if typeset -f "${FUNCTION_NAME}" > /dev/null ; then
"${FUNCTION_NAME}" $2 $3 $4 $5 $6 $7 $8 $9
else
echo "$1 was incorrectly defined. 'performAction' not defined"
exit;
fi
