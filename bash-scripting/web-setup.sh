#!/bin/bash
source ./utils.sh
source ./logger.sh

logInfo "Updating the server"
sudo apt update
logInfo "Successfully updated the server"

# Check apache 2 is installed or not. If not then install it.
logInfo "Checking apache2 is installed or not."
if dpkg -s apache2 &> /dev/null; then
    logInfo "Apache2 is installed."
    # Check is service running or not
    if ! systemctl is-active --quiet apache2; then
        sudo systemctl start apache2
        logInfo "Started apache2 service"
    fi
else
    logInfo "Apache2 is not installed. Installing Apache2 service."
    sudo apt install -y apache2 >> /dev/null 
    sudo systemctl start apache2
    sudo systemctl status apache2
    logInfo "Apache2 is installed successfully."
fi

logInfo "Check wget, unzip, zip service is installed or not"
checkAndInstall "wget"
checkAndInstall "unzip"
checkAndInstall "zip"


logInfo "Downloading website and setup things"
cd /opt
wget -r "https://www.tooplate.com/zip-templates/2153_fireworks_composer.zip"
unzip 2153_fireworks_composer.zip
rm -rf /var/www/html/*
cp ./2153_fireworks_composer/* /var/www/html
logInfo "Website setup done"
show ip addr

