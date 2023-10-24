#!/bin/bash

# Function to display users and their groups and identify root users
list_users() {
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
}

# Function to promote/demote user
modify_user() {
    read -p "Enter the username to promote/demote: " username
    read -p "Promote or demote? (p/d): " action

    if [[ "$action" == "p" ]]; then
        sudo usermod -aG sudo $username
        echo "$username has been promoted to admin."
    elif [[ "$action" == "d" ]]; then
        sudo deluser $username sudo
        echo "$username has been demoted from admin."
    else
        echo "Invalid choice. Please enter 'p' to promote or 'd' to demote."
    fi
    echo
}

# Function to add/remove user from a group
manage_group() {
    read -p "Enter the username: " username
    read -p "Enter the group name: " groupname
    read -p "Add or remove from group? (a/r): " action

    if [[ "$action" == "a" ]]; then
        sudo usermod -aG $groupname $username
        echo "$username has been added to $groupname."
    elif [[ "$action" == "r" ]]; then
        sudo gpasswd -d $username $groupname
        echo "$username has been removed from $groupname."
    else
        echo "Invalid choice. Please enter 'a' to add or 'r' to remove."
    fi
    echo
}

# Function to display menu
show_menu() {
    echo "1. List users"
    echo "2. Promote/Demote user"
    echo "3. Manage user group membership"
    echo "4. Exit"
}

# Main loop
while true; do
    show_menu
    read -p "Enter your choice: " choice

    case $choice in
        1) list_users;;
        2) modify_user;;
        3) manage_group;;
        4) exit 0;;
        *) echo "Invalid choice, please enter a number between 1 and 4.";;
    esac
done
