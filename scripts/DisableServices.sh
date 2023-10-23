#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)." 
   exit 1
fi

SERVICES=("postfix" "dovecot" "apache2" "nginx" "samba" "sshd")

# Function to check the status of a service
check_service_status() {
    if systemctl is-active --quiet "$1"; then
        echo "$1 is installed and currently running."
    elif systemctl is-enabled --quiet "$1"; then
        echo "$1 is installed but not currently running."
    else
        echo "$1 is not installed or enabled on this system."
    fi
}

# Function to disable a service
disable_service() {
    systemctl stop "$1"
    systemctl disable "$1"
    echo "$1 has been disabled and stopped."
}

# Check the status of services
for service in "${SERVICES[@]}"; do
    check_service_status "$service"
done

# Prompt to disable services
for service in "${SERVICES[@]}"; do
    read -p "Do you want to disable $service? (y/n): " choice
    if [[ "$choice" =~ ^[yY] ]]; then
        disable_service "$service"
    fi
done

echo "Service disabling process completed."
