#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Flushing all rules
iptables -F
iptables -X

# Setting default filter policy
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow incoming ssh only
iptables -A INPUT -p tcp -s 0/0 -d 0/0 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s 0/0 -d 0/0 --sport 22 -m state --state ESTABLISHED -j ACCEPT

# Allow incoming http and https
iptables -A INPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT

# Save settings
/sbin/service iptables save

# List rules
iptables -L -v

echo "Iptables have been configured and saved successfully."

