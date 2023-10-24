#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)." 
   exit 1
fi

if grep -q 'ID=ubuntu\|ID=debian' /etc/os-release; then
    # Installing unattended-upgrades
    apt-get update
    apt-get install -y unattended-upgrades

    # Enabling unattended-upgrades
    dpkg-reconfigure --priority=low unattended-upgrades

    # Configuring unattended-upgrades to install security updates automatically
    echo 'Unattended-Upgrade::Allowed-Origins {
        "${distro_id}:${distro_codename}-security";
    };' > /etc/apt/apt.conf.d/50unattended-upgrades

    echo "Unattended upgrades configured successfully."

elif grep -q 'ID=fedora' /etc/os-release; then
    # Installing dnf-automatic
    dnf install -y dnf-automatic

    # Enabling and starting dnf-automatic
    systemctl enable --now dnf-automatic.timer

    # Configuring dnf-automatic to apply updates
    sed -i 's/apply_updates = no/apply_updates = yes/' /etc/dnf/automatic.conf

    echo "dnf-automatic configured successfully."

else
    echo "Unsupported distribution!"
    exit 1
fi
