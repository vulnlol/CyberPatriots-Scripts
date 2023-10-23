#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)." 
   exit 1
fi

# Function to confirm an action
confirm() {
    read -p "$1 (y/n): " choice
    case "$choice" in
        y|Y ) return 0;;
        * ) return 1;;
    esac
}

# Ensure the cron daemon is running
if systemctl is-active --quiet cron || systemctl is-active --quiet crond; then
    echo "Cron daemon is running."
else
    if confirm "Cron daemon is not running. Would you like to start it?"; then
        systemctl start cron || systemctl start crond
        systemctl enable cron || systemctl enable crond
        echo "Cron daemon started and enabled."
    fi
fi

# Secure the cron directories and files
chmod 700 /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.monthly /etc/cron.weekly
chmod 600 /etc/crontab

# Remove suspicious cron jobs (you can customize this part based on your needs)
if confirm "Would you like to review and remove suspicious cron jobs?"; then
    crontab -l | grep -e 'wget' -e 'curl' | crontab -
    echo "Suspicious cron jobs removed."
fi

# Allow or deny users to run cron jobs
if confirm "Would you like to manage users' access to cron?"; then
    echo "1. Allow user"
    echo "2. Deny user"
    read -p "Choose an option: " option

    case "$option" in
        1) 
            read -p "Enter the username to allow: " username
            sed -i "/^$username$/d" /etc/cron.deny
            echo "User '$username' is allowed to run cron jobs."
            ;;
        2) 
            read -p "Enter the username to deny: " username
            echo "$username" >> /etc/cron.deny
            echo "User '$username' is denied to run cron jobs."
            ;;
        *) 
            echo "Invalid option."
            ;;
    esac
fi

echo "Cron jobs secured."
