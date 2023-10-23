#!/bin/bash

# Function to display the menu
display_menu() {
    echo "1. Add User"
    echo "2. Delete User"
    echo "3. Change User Password"
    echo "4. Exit"
    read -p "Please choose an option: " choice
}

# Function to add a user
add_user() {
    read -p "Enter the username to add: " username
    sudo adduser "$username"
    echo "User $username added successfully!"
}

# Function to delete a user
delete_user() {
    read -p "Enter the username to delete: " username
    sudo deluser "$username"
    echo "User $username deleted successfully!"
}

# Function to change a user's password
change_password() {
    read -p "Enter the username to change the password for: " username
    sudo passwd "$username"
    echo "Password for $username changed successfully!"
}

# Main function to execute the options
manage_users() {
    while true; do
        display_menu
        
        case $choice in
            1) add_user ;;
            2) delete_user ;;
            3) change_password ;;
            4) break ;;
            *) echo "Invalid option, please choose again." ;;
        esac
    done
}

# Calling the main function
manage_users
