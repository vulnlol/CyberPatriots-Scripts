#!/bin/bash

# Function to list all files in user directories excluding hidden directories
list_user_files() {
    # Loop through home directories
    for user_home in /home/*; do
        user=$(basename "$user_home")

        echo "Listing files in $user_home..."

        # Find and list files, excluding hidden directories and files
        find "$user_home" -type f ! -path "$user_home/.*/*" -print | while read -r file; do
            echo "$file"
        done

        echo ""  # Adding an empty line for better readability between users
    done
}

# Call the function
list_user_files
