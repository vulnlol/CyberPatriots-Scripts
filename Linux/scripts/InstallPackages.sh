#!/bin/bash

# Function to get packages to install from the user
get_packages_to_install() {
    echo "Enter the names of the packages you want to install, separated by spaces (e.g., package1 package2 package3):"
    read -a packages
}

# Function to install packages
install_packages() {
    if [[ ${#packages[@]} -eq 0 ]]; then
        echo "No packages were provided for installation. Exiting."
        exit 1
    fi

    if command -v apt-get &> /dev/null; then
        # Using apt-get (for Debian/Ubuntu)
        apt-get update
        apt-get install -y "${packages[@]}"
    elif command -v dnf &> /dev/null; then
        # Using dnf (for Fedora)
        dnf install -y "${packages[@]}"
    else
        echo "Unsupported package manager. Exiting."
        exit 1
    fi
    echo "Installation of packages complete."
}

# Function to enable and start services
manage_services() {
    for package in "${packages[@]}"; do
        read -p "Do you want to enable and start the service related to $package? (y/n): " choice
        case "$choice" in
            y|Y )
                systemctl enable "$package"
                systemctl start "$package"
                echo "Service for $package enabled and started."
                ;;
            * )
                echo "Service for $package not modified."
                ;;
        esac
    done
}

# Main execution starts here
get_packages_to_install
install_packages
manage_services
