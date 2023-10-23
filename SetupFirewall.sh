#!/bin/bash

# Function to prompt user for confirmation
confirm() {
    read -p "$1 (y/n): " choice
    case "$choice" in
        y|Y ) return 0;;
        * ) return 1;;
    esac
}

# Detecting the distribution
if grep -q 'ID=ubuntu\|ID=debian' /etc/os-release; then
    INSTALL_CMD="apt-get install -y"
elif grep -q 'ID=fedora' /etc/os-release; then
    INSTALL_CMD="dnf install -y"
else
    echo "Unsupported distribution!"
    exit 1
fi

# Checking if UFW is installed
if ! command -v ufw &> /dev/null; then
    if confirm "UFW is not installed. Do you want to install it?"; then
        $INSTALL_CMD ufw
        echo "UFW installed successfully!"
        
        if confirm "Do you want to enable UFW?"; then
            sudo ufw enable
            echo "UFW enabled successfully!"
        fi
    fi
else
    echo "UFW is already installed."
    if confirm "Do you want to enable UFW?"; then
        sudo ufw enable
        echo "UFW enabled successfully!"
    fi
fi
