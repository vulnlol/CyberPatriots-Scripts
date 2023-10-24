#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)." 
   exit 1
fi

# Function to list all files in user directories excluding hidden directories
list_user_files() {
    declare -a filesArray
    counter=0
    
    # Loop through home directories
    for user_home in /home/*; do
        user=$(basename "$user_home")
        
        # Header for each user
        echo "---------------------------------------"
        echo "Files in /home/$user:"
        echo "---------------------------------------"
        
        # Find and list files, excluding hidden directories and files, and populate array
        while IFS=  read -r -d $'\0'; do
            counter=$((counter+1))
            filesArray["$counter"]=$REPLY
            echo "$counter. ${filesArray[$counter]}"
        done < <(find "$user_home" -type f ! -path "$user_home/.*/*" -print0)
        
        echo ""  # Adding an empty line for better readability between users
    done

    # Prompt for files to delete
    echo "---------------------------------------"
    read -p "Enter the numbers of the files you want to delete (separated by space), or press Enter to skip: " filesToDelete

    if [[ $filesToDelete ]]; then
        for fileNumber in $filesToDelete; do
            if [[ -e "${filesArray[$fileNumber]}" ]]; then
                rm "${filesArray[$fileNumber]}"
                echo "Deleted: ${filesArray[$fileNumber]}"
            else
                echo "Invalid selection: $fileNumber. No such file number exists."
            fi
        done
    else
        echo "No files were deleted."
    fi
}

# Execute the function to list files and prompt for deletion
list_user_files
