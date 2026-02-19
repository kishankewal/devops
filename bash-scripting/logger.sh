#!/bin/bash
DATE=$(date +"%d-%h-%y");
FILE_NAME="LOG-$DATE.txt"
function logInfo() {
        echo "LOG_INFO DATE : $(date) || Message : $1" >> $FILE_NAME
}
