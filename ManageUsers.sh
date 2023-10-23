#!/bin/bash

# Function to prompt user for confirmation
confirm() {
    read -p "$1 (y/n): " choice
    case "$choice" in
        y|Y ) return 0;;
        * ) return 1;;
    esac
}

# ... (other functions remain the same)

# Function to lock a user account
lock_user() {
    read -p "Enter the username to lock: " username
    passwd -l "$username"
    echo "User $username locked successfully!"
}

# Function to unlock a user account
unlock_user() {
    read -p "Enter the username to unlock: " username
    passwd -u "$username"
    echo "User $username unlocked successfully!"
}

# Function to manage user sudo privileges
manage_sudo() {
    read -p "Enter the username: " username
    read -p "Assign or revoke sudo privileges? (assign/revoke): " choice

    case "$choice" in
        assign) usermod -aG sudo "$username";;
        revoke) deluser "$username" sudo;;
        *) echo "Invalid option. Choose 'assign' or 'revoke'.";;
    esac
}

# Main menu to manage users
while true; do
    echo "1. Add User"
    echo "2. Delete User"
    echo "3. Modify User Password"
    echo "4. Lock User"
    echo "5. Unlock User"
    echo "6. Manage User Sudo Privileges"
    echo "7. List Users"
    echo "8. Exit"
    read -p "Choose an option: " option

    case "$option" in
        1) add_user;;
        2) delete_user;;
        3) modify_user_password;;
        4) lock_user;;
        5) unlock_user;;
        6) manage_sudo;;
        7) list_users;;
        8) exit;;
        *) echo "Invalid option! Please enter a number between 1 and 8.";;
    esac
done
