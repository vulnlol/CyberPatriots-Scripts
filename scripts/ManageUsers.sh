#!/bin/bash

# Function to display users and their groups and identify root users
echo "Listing users:"
for user in $(getent passwd | cut -d: -f1); do
    uid=$(id -u $user)
    groups=$(id -Gn $user)
    if [[ $uid -eq 0 ]] || [[ $groups =~ "sudo" ]] || [[ $groups =~ "root" ]]; then
        echo "* $user is a ROOT user. Groups: $groups"
    else
        echo "  $user. Groups: $groups"
    fi
done
echo

# Function to add a new user
add_user() {
    read -p "Enter the new username: " username
    sudo adduser $username
    read -sp "Enter the password for $username: " password
    echo -e "$password\n$password" | sudo passwd $username
    echo
    echo "$username has been added with the specified password."
    echo
}

# Function to lock a user account
lock_user() {
    read -p "Enter the username to lock: " username
    sudo passwd -l $username
    echo "$username has been locked."
    echo
}

# Other functions like change_password, modify_user, and show_menu go here

# Function to display menu
show_menu() {
    echo "1. Add new user"
    echo "2. Change user password"
    echo "3. Promote/Demote user"
    echo "4. Lock user account"
    echo "5. Exit"
}

# Main loop
while true; do
    show_menu
    read -p "Enter your choice: " choice

    case $choice in
        1) add_user;;
        2) change_password;;
        3) modify_user;;
        4) lock_user;;
        5) exit 0;;
        *) echo "Invalid choice, please enter a number between 1 and 5.";;
    esac
done