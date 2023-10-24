#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)." 
   exit 1
fi

# List available display managers
echo "Available Display Managers:"

# Detecting if the system is Debian/Ubuntu based or Fedora based
if grep -q 'ID=ubuntu\|ID=debian' /etc/os-release; then
    REMOVE_CMD="apt-get purge -y"
    DM_LIST=($(dpkg -l | grep -E "^\ii\s+gdm3|sddm|lightdm|xdm|kdm|lxdm" | awk '{print $2}'))
elif grep -q 'ID=fedora' /etc/os-release; then
    REMOVE_CMD="dnf remove -y"
    DM_LIST=($(rpm -qa | grep -E "gdm|sddm|lightdm|xdm|kdm|lxdm"))
else
    echo "Unsupported distribution!"
    exit 1
fi

for i in "${!DM_LIST[@]}"; do
    echo "$((i+1)). ${DM_LIST[i]}"
done

# Prompt user to choose which display manager to keep
read -p "Enter the number of the display manager to keep: " choice

if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#DM_LIST[@]}" ]; then
    KEEP_DM="${DM_LIST[$((choice-1))]}"
    echo "Keeping $KEEP_DM."

    # Disable and uninstall other display managers
    for dm in "${DM_LIST[@]}"; do
        if [[ "$dm" != "$KEEP_DM" ]]; then
            echo "Removing $dm..."
            systemctl disable "$dm"
            $REMOVE_CMD "$dm"
        fi
    done

    # Enable the chosen display manager
    systemctl enable "$KEEP_DM"
else
    echo "Invalid selection. Exiting without making changes."
    exit 1
fi
