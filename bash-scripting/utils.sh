#!/bin/bash
source ./logger.sh

function loader() {
    COUNT=0
    printf "Loading"
    while [ $COUNT -lt 3 ]; do
        printf ".";
            sleep 0.3
            ((COUNT++))
    done
    printf "\n"
}

checkAndInstall() {
    PACKAGE=$1

    if command -v $PACKAGE &> /dev/null; then
        logInfo "$PACKAGE is already installed"
    else
        logInfo "$PACKAGE not found. Installing..."

        # Detect OS
        if [ -f /etc/debian_version ]; then
            sudo apt install -y $PACKAGE
        elif [ -f /etc/redhat-release ]; then
            sudo yum install -y $PACKAGE
        else
            echo "Unsupported OS"
            exit 1
        fi
    fi
}
