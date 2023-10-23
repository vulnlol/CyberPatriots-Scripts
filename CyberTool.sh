#!/bin/bash

SCRIPT_DIR="$(dirname "$0")/scripts"

# Function to display the menu and get user selection
select_scripts() {
    scripts=($SCRIPT_DIR/*)
    echo "Available scripts:"
    for i in "${!scripts[@]}"; do
        echo "$((i+1)). $(basename "${scripts[$i]}")"
    done
    echo

    read -p "Enter the numbers of the scripts you want to run (separated by space): " choices
    echo
}

# Function to run the selected scripts
run_selected_scripts() {
    for choice in $choices; do
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#scripts[@]}" ]; then
            echo "Running ${scripts[$((choice-1))]}"
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
