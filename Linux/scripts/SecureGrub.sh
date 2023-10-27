#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit
fi

# Check if GRUB is installed
if ! command -v grub-mkpasswd-pbkdf2 &> /dev/null; then
    echo "GRUB is not installed. Exiting script."
    exit
fi

# Prompting user for a username and password
read -p "Enter the username: " grub_username
echo "Enter the password: "
grub_password=$(grub-mkpasswd-pbkdf2 | grep "grub.pbkdf2" | cut -d ' ' -f7)

# Backup the current GRUB configuration file
cp /etc/grub.d/40_custom /etc/grub.d/40_custom.backup

# Adding the credentials to the 40_custom file
echo "set superusers=\"$grub_username\"" >> /etc/grub.d/40_custom
echo "password_pbkdf2 $grub_username $grub_password" >> /etc/grub.d/40_custom

# Updating GRUB
update-grub

echo "GRUB has been secured. A username and password will be required to edit GRUB menu entries at boot."
