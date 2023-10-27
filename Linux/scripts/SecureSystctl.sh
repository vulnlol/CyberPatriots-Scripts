#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Backup the original sysctl.conf file
cp /etc/sysctl.conf /etc/sysctl.conf.backup

# Define the kernel parameters to secure the sysctl configuration
SECURE_KERNEL_PARAMS="
# Disable packet forwarding
net.ipv4.ip_forward = 0
net.ipv6.conf.all.forwarding = 0

# Disable IP source routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0

# Disable ICMP redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0

# Enable TCP SYN cookies
net.ipv4.tcp_syncookies = 1

# Log suspicious packets (martians)
net.ipv4.conf.all.log_martians = 1

# Ignore ICMP echo requests
net.ipv4.icmp_echo_ignore_all = 1
"

# Apply the kernel parameters to sysctl.conf
echo "$SECURE_KERNEL_PARAMS" >> /etc/sysctl.conf

# Reload sysctl to apply the new configurations
sysctl -p

# Output message to indicate the completion of the script
echo "sysctl.conf has been secured and the new configurations have been applied."

