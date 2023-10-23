#!/bin/bash

# Check if SSH is installed
if ! command -v ssh &> /dev/null; then
    echo "SSH is not installed. Exiting."
    exit 1
fi

# Path to the SSH daemon configuration file
SSHD_CONFIG="/etc/ssh/sshd_config"

# Check if the SSH configuration file exists
if [ ! -f "$SSHD_CONFIG" ]; then
    echo "SSH configuration file ($SSHD_CONFIG) not found. Exiting."
    exit 1
fi

# Function to disable SSH root login
disable_ssh_root_login() {
    # Check if root login is already disabled
    if grep -q "^PermitRootLogin no" "$SSHD_CONFIG"; then
        echo "SSH root login is already disabled."
    else
        # Disable root login
        sed -i "/^PermitRootLogin/c\PermitRootLogin no" "$SSHD_CONFIG"
        if [ $? -eq 0 ]; then
            echo "SSH root login disabled successfully."
        else
            echo "Failed to disable SSH root login."
            exit 1
        fi
        
        # Restart SSH service to apply changes
        service ssh restart
        echo "SSH service restarted successfully."
    fi
}

# Execute the function to disable SSH root login
disable_ssh_root_login
