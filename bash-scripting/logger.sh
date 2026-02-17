#!/bin/bash

echo "This script is use logging disk space, top files consuming space and top 5 process"
read -p "Do you have already created a logging file ? (y/n): " IS_FILE_CREATED

userLogHandler() {
        if [ "$1" == "RETRY" ]; then
                echo "You have entered a wrong input. Please choose options from A, B or C"
        else
                echo "Good now please let us know. What details you want to log ?"
        fi
        echo "A. List of top process 5 process"
        echo "B. Check free space"
        echo "C. Check top files consuming space"
        echo ""
        read -p "Enter your option: " OPTION
        case "${OPTION^^}" in
                "A")
                        echo "Recording top 5 CPU consuming processes..."
                        echo "Top 5 CPU consuming processes" >> $2 2> /dev/null
                        echo "==============================================="  >> $2 2> /dev/null
                        ps -eo pid,cmd,%cpu --sort=-%cpu | head -n 6 >> $2
                        echo "==============================================="  >> $2 2> /dev/null

                        ;;
                "B")
                        echo "Logging free space..."
                        echo "Top 5 CPU consuming processes" >> $2  2> /dev/null
                        echo "==============================================="  >> $2 2> /dev/null
                        free -h >> $2
                        echo "==============================================="  >> $2 2> /dev/null
                        ;;
                "C")
                        echo "Logging top files that are consuming space..."
                        echo "Top 5 files that are consuming space" >> $2  2> /dev/null
                        echo "==============================================="  >> $2 2> /dev/null
                        df -h >> $2
                        echo "==============================================="  >> $2 2> /dev/null
                        ;;
                *)
                        userLogHandler "RETRY"
                        ;;
        esac
        echo "Data logged successfully. :)"
        read -p "Do you want to log other data ? (y/n)" LOG_OTHER_DATA
        if [[ "${LOG_OTHER_DATA^^}" == "Y" ]]; then
                userLogHandler "" "$2"
        else 
                echo "Good bye then";
        fi
}

createLogFile(){
        echo ""
        echo "Should we create a new file ?"
        read -p "Yes Or No : " CREATE_FILE
        if [[ "${CREATE_FILE^^}" == "YES" ]]; then
                read -p "Good. What should be the name of log file ? " FILE_NAME
                touch "$FILE_NAME.txt"
                userLogHandler "" "$FILE_NAME.txt"
        fi
}

if [[ "${IS_FILE_CREATED^^}" == "Y" ]]; then
        read -p "Please enter file name: " FILE_PATH
        if [[ -e "$FILE_PATH" ]]; then
                userLogHandler "" "$FILE_PATH"
        else
                echo "$FILE_PATH Does not exist. "
                createLogFile
        fi
else
        createLogFile
fi