#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# An array of sysctl configurations
declare -a sysctl_configs=(
"fs.file-max = 65535"
"fs.protected_fifos = 2"
"fs.protected_regular = 2"
# ... (add all other configurations here) ...
"net.ipv4.tcp_wmem = 10240 87380 12582912"
"net.ipv6.conf.all.disable_ipv6 = 1"
"net.ipv6.conf.default.disable_ipv6 = 1"
"net.ipv6.conf.lo.disable_ipv6 = 1"
)

# Randomly shuffle the configurations
shuffled_sysctl_configs=($(for i in "${sysctl_configs[@]}"; do echo "$i"; done | shuf))

# Apply the configurations
for config in "${shuffled_sysctl_configs[@]}"
do
   key=$(echo $config | cut -d' ' -f 1)
   value=$(echo $config | cut -d' ' -f 3)
   sysctl -w "$key=$value"
done

# Save the configurations permanently
sysctl -p

echo "sysctl configurations have been randomized and applied successfully."
