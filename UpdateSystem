#!/bin/bash

# Function to prompt user for confirmation
confirm() {
    read -p "$1 (y/n): " choice
    case "$choice" in
        y|Y ) return 0;;
        * ) return 1;;
    esac
}

# Detecting the distribution and setting up commands
if grep -q 'ID=ubuntu\|ID=debian' /etc/os-release; then
    UPDATE_CMD="apt-get update"
    UPGRADE_CMD="apt-get upgrade -y"
elif grep -q 'ID=fedora' /etc/os-release; then
    UPDATE_CMD="dnf check-update"
    UPGRADE_CMD="dnf upgrade -y"
else
    echo "Unsupported distribution!"
    exit 1
fi

# Updating the system
if confirm "Do you want to update the system?"; then
    $UPDATE_CMD && $UPGRADE_CMD
fi
