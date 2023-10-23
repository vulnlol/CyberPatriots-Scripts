#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)." 
   exit 1
fi

SCRIPT_DIR="$(dirname "$0")/scripts"

echo "
  ____      _                 _____           _ 
 / ___|   _| |__   ___ _ __  |_   _|__   ___ | |
| |  | | | | '_ \ / _ \ '__|   | |/ _ \ / _ \| |
| |__| |_| | |_) |  __/ |      | | (_) | (_) | |
 \____\__, |_.__/ \___|_|      |_|\___/ \___/|_|
      |___/                                     
"

# Function to display the menu and get user selection
select_scripts() {
    scripts=($SCRIPT_DIR/*)
    echo "Available scripts:"
    echo "0. Run all scripts"
    for i in "${!scripts[@]}"; do
        echo "$((i+1)). $(basename "${scripts[$i]}" .sh)"
    done
    echo

    read -p "Enter the numbers of the scripts you want to run (separated by space): " choices
    echo
}

# Function to run the selected scripts
run_selected_scripts() {
    for choice in $choices; do
        if [[ "$choice" == 0 ]]; then
            for script in "${scripts[@]}"; do
                echo "Running $(basename "$script" .sh)"
                bash "$script"
                echo
            done
        elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#scripts[@]}" ]; then
            echo "Running $(basename "${scripts[$((choice-1))]}" .sh)"
            bash "${scripts[$((choice-1))]}"
            echo
        else
            echo "Invalid selection: $choice"
        fi
    done
}

# Main execution starts here
while true; do
    select_scripts
    run_selected_scripts

    read -p "Do you want to run another script? (y/n): " run_again
    [[ "$run_again" =~ [yY] ]] || break
    echo
done
