#!/bin/bash

# Function to prompt user for confirmation
confirm() {
    read -p "$1 (y/n): " choice
    case "$choice" in
        y|Y ) return 0;;
        * ) return 1;;
    esac
}

# Detecting the distribution
if grep -q 'ID=ubuntu\|ID=debian' /etc/os-release; then
    REMOVE_CMD="apt-get purge -y"
elif grep -q 'ID=fedora' /etc/os-release; then
    REMOVE_CMD="dnf remove -y"
else
    echo "Unsupported distribution!"
    exit 1
fi

# List of prohibited hacking tools
HACKING_TOOLS=("ophcrack" "wireshark" "nmap" "john" "hydra" "metasploit-framework" "aircrack-ng" "nikto" "tcpdump" "burpsuite" "sqlmap" "hashcat" "ettercap-text-only" "kismet" "reaver" "radare2" "wifite")

# Checking each tool, and prompting for removal if it's installed
for tool in "${HACKING_TOOLS[@]}"; do
    if dpkg -l | grep -q "$tool"; then
        if confirm "$tool is installed. Do you want to remove it?"; then
            $REMOVE_CMD "$tool"
        fi
    fi
done
