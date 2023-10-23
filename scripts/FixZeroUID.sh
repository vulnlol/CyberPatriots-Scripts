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

# Check for users with UID 0
while IFS=: read -r username password uid gid fullname homedir shell; do
    if [[ "$uid" -eq 0 && "$username" != "root" ]]; then
        echo "User '$username' has UID 0."

        if confirm "Would you like to modify the UID and GID for '$username'?"; then
            # Find a new unique UID and GID
            new_uid=$(awk -F: '{if(max<\$3+1)max=\$3+1}END{print max}' /etc/passwd)
            new_gid=$(awk -F: '{if(max<\$3+1)max=\$3+1}END{print max}' /etc/group)

            usermod -u "$new_uid" "$username"
            groupmod -g "$new_gid" "$username"
            echo "UID and GID for '$username' modified to $new_uid and $new_gid respectively."
        fi
    fi
done < /etc/passwd

echo "UID 0 check completed."
