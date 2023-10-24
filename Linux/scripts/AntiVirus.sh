#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)." 
   exit 1
fi

# Install and run ClamAV
if ! dpkg -l | grep -q "clamav"; then
    apt-get update
    apt-get install clamav clamav-daemon -y
fi

# Install and run chkrootkit
if ! dpkg -l | grep -q "chkrootkit"; then
    apt-get install chkrootkit -y
fi

# Install and run rkhunter
if ! dpkg -l | grep -q "rkhunter"; then
    apt-get install rkhunter -y
fi

# Update ClamAV and rkhunter databases
freshclam
rkhunter --update

# Run chkrootkit
chkrootkit > /var/log/chkrootkit.log

# Run rkhunter
rkhunter --check --skip-keypress --report-warnings-only | tee /var/log/rkhunter.log

# Run ClamAV
clamscan -r /home --move=/home/QUARANTINE | tee /var/log/clamav_scan.log

echo "Scans completed. Logs:"
echo "- ClamAV: /var/log/clamav_scan.log"
echo "- chkrootkit: /var/log/chkrootkit.log"
echo "- rkhunter: /var/log/rkhunter.log"
