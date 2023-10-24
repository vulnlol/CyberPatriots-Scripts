#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)." 
   exit 1
fi

# Displaying text art


# Defining the directory where the scripts are located
SCRIPT_DIR="$(dirname "$0")/scripts"

# Function to display the available scripts in a menu format
show_scripts() {
    clear
    echo "  ____      _                 _____           _ "
    echo " / ___|   _| |__   ___ _ __  |_   _|__   ___ | |"
    echo "| |  | | | | '_ \ / _ \ '__|   | |/ _ \ / _ \| |"
    echo "| |__| |_| | |_) |  __/ |      | | (_) | (_) | |"
    echo " \____\__, |_.__/ \___|_|      |_|\___/ \___/|_|"
    echo "      |___/                                      "
    echo ""
    echo "For Cyber Patriot XVI"
    echo ""
    scripts=($(ls $SCRIPT_DIR/*.sh))
    echo "Available scripts:"
    for i in "${!scripts[@]}"; do
        echo "$((i+1)). $(basename "${scripts[$i]}" .sh)"
    done
    echo "A. Execute all scripts"
    echo
}

# Function to execute selected scripts
execute_scripts() {
    read -p "Enter the numbers or letter of the scripts you want to run (separated by space): " choices
    for choice in $choices; do
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#scripts[@]}" ]; then
            sudo bash "${scripts[$((choice-1))]}"
        elif [[ "$choice" =~ ^[Aa]$ ]]; then
            for script in "${scripts[@]}"; do
                sudo bash "$script"
            done
        else
            echo "Invalid selection: $choice. Please enter a valid number or letter (A)."
        fi
    done
}

# Main loop to display the menu and get the user selection
while true; do
    show_scripts
    execute_scripts
    read -p "Do you want to execute another script? (y/n): " response
    [[ "$response" =~ ^[Yy]$ ]] || exit
    clear
done
