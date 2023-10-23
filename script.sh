#!/bin/bash

# Detecting the distribution
if grep -q 'ID=ubuntu\|ID=debian' /etc/os-release; then
    INSTALL_CMD="apt-get install -y"
    REMOVE_CMD="apt-get purge -y"
    UPDATE_CMD="apt-get update"
    UPGRADE_CMD="apt-get upgrade -y"
elif grep -q 'ID=fedora' /etc/os-release; then
    INSTALL_CMD="dnf install -y"
    REMOVE_CMD="dnf remove -y"
    UPDATE_CMD="dnf update"
    UPGRADE_CMD="dnf upgrade -y"
else
    echo "Unsupported distribution!"
    exit 1
fi

# Install and enable Uncomplicated Firewall (UFW) or firewalld for Fedora
if grep -q 'ID=ubuntu\|ID=debian' /etc/os-release; then
    if ! command -v ufw &> /dev/null; then
        $UPDATE_CMD
        $INSTALL_CMD ufw
        ufw enable
    fi
elif grep -q 'ID=fedora' /etc/os-release; then
    if ! command -v firewall-cmd &> /dev/null; then
        $INSTALL_CMD firewalld
        systemctl start firewalld
        systemctl enable firewalld
    fi
fi

# Other system configurations...

# Set default maximum password age
chage -M 60 -m 7 -W 7

# Installing necessary packages
$INSTALL_CMD postgresql

# Disabling and removing services
systemctl disable apache2
$REMOVE_CMD apache2

# Ensure the system automatically checks for updates
$INSTALL_CMD dnf-automatic

# Update packages
$UPDATE_CMD
$UPGRADE_CMD

# Remove prohibited software
$REMOVE_CMD ophcrack
$REMOVE_CMD wireshark

# Disable SSH root login
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
systemctl restart sshd
