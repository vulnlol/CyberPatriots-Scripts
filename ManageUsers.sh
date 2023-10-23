#!/bin/bash

# Function to confirm action
confirm() {
    read -p "$1 (y/n): " choice
    case "$choice" in
        y|Y ) return 0;;
        * ) return 1;;
    esac
}

# Function to check if a user is a sudoer
is_sudoer() {
    sudo -l -U "$1" | grep -q "(ALL : ALL) ALL"
    return $?
}

# Function to list users and their groups
list_users() {
    users=$(getent passwd | cut -d: -f1)
    echo "Listing users and their groups:"
    for user in $users; do
        if is_sudoer "$user"; then
            echo -e "\n* [ADMIN] User: $user"
        else
            echo -e "\n* User: $user"
        fi
        groups=$(id -Gn "$user" | tr ' ' ', ')
        echo "  - Groups: $groups"
    done
}

# Function to change user password
change_password() {
    read -p "Enter the username to change the password: " username
    sudo passwd "$username"
}

# Display menu and execute choice
while true; do
    echo "1. List users"
    echo "2. Change user password"
    echo "3. Exit"
    read -p "Choose an option: " option
