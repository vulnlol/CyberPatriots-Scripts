#!/bin/bash

# Function to prompt user for confirmation
confirm() {
    read -p "$1 is installed. Do you want to remove it? (y/n): " choice
    case "$choice" in
        y|Y ) return 0;;
        * ) return 1;;
    esac
}

# Detecting the distribution and setting the appropriate remove command and package query command
if grep -q 'ID=ubuntu\|ID=debian' /etc/os-release; then
    REMOVE_CMD="apt-get purge -y"
    QUERY_CMD="dpkg -l"
elif grep -q 'ID=fedora' /etc/os-release; then
    REMOVE_CMD="dnf remove -y"
    QUERY_CMD="rpm -q"
else
    echo "Unsupported distribution!"
    exit 1
fi

# List of prohibited hacking tools
HACKING_TOOLS=("ophcrack" "wireshark" "nmap" "john" "hydra" "metasploit-framework" "aircrack-ng" "nikto" "tcpdump" "burpsuite" "sqlmap" "hashcat" "ettercap-text-only" "kismet" "reaver" "radare2" "wifite")

# Checking each tool, and prompting for removal if it's installed
for tool in "${HACKING_TOOLS[@]}"; do
    if $QUERY_CMD "$tool" > /dev/null 2>&1; then
        if confirm "$tool"; then
            $REMOVE_CMD "$tool"
            echo "$tool has been removed."
        else
            echo "Skipping $tool."
        fi
    else
        echo "$tool is not installed."
    fi
    echo
done
