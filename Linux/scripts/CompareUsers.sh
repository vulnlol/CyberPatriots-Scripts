#!/bin/bash

# Define file paths
USERS_FILE="users_list.txt"
ADMINS_FILE="admins_list.txt"

# Check if files exist
if [[ ! -f $USERS_FILE ]] || [[ ! -f $ADMINS_FILE ]]; then
    echo "Error: User list files do not exist."
    exit 1
fi

# Function to check users
check_users() {
    userType=$1
    file=$2
    
    echo "Checking $userType:"
    
    # Reading each user from the file and checking if they exist in the system
    while read user; do
        if id "$user" &>/dev/null; then
            echo "  $user exists in the system."
            
            # Check if the user is supposed to be an admin
            if [[ $userType == "administrators" ]]; then
                if groups "$user" | grep -q "sudo\|wheel"; then
                    echo "  $user is an administrator."
                else
                    echo "  Warning: $user should be an administrator but is not."
                fi
            fi
        else
            echo "  Warning: $user does not exist in the system."
        fi
    done < "$file"
}

# Execute the check_users function for normal users and administrators
check_users "normal users" "$USERS_FILE"
echo
check_users "administrators" "$ADMINS_FILE"
