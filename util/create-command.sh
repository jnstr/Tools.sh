#!/bin/bash

DESCRIPTION="Create a new command for this tools script"


performAction() {
    echo "What namespace do you want to use"
    read NAMESPACE
    NAMESPACE=$(sanitize_file_name "$NAMESPACE")

    DIRECTORY="$ROOT_DIR/$NAMESPACE"
    if [ ! -d $DIRECTORY ]; then
        mkdir $DIRECTORY
    fi

    echo "What action name do you want to use"
    read ACTIONNAME
    ACTIONNAME=$(sanitize_file_name "$ACTIONNAME")

    FILE_NAME="$ROOT_DIR/$NAMESPACE/$ACTIONNAME.sh"
    if [ -f $FILE_NAME ]; then
        echo ""
        echo "$NAMESPACE:$ACTIONNAME already exists. Exiting now..."
        exit;
    fi

    echo "Give a short description for the command"
    read DESCRIPTION


    cat> $FILE_NAME  << EOF
#!/bin/bash

DESCRIPTION="$DESCRIPTION"


performAction() {
    echo "Todo"
}
EOF

echo ""
echo "Command $NAMESPACE:$ACTIONNAME has been created."
echo "The file is located at $FILE_NAME"

}

sanitize_file_name() {
    echo -n $1 | perl -pe 's/[\?\[\]\/\\=<>:;,''"&\$#*()|~`!{}%+]//g;' -pe 's/[\r\n\t -]+/-/g;'
}