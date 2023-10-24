#!/bin/bash

# Define well-known repository URLs or parts of URLs. Adjust this list as necessary.
WELL_KNOWN_REPOS=("http://archive.ubuntu.com" "http://security.ubuntu.com" "http://ppa.launchpad.net" "http://deb.debian.org" "http://security.debian.org" "https://download.fedoraproject.org" "http://mirror.centos.org" "https://archive.fedoraproject.org")

# Function to check if a repository is well-known
is_well_known_repo() {
    for known_repo in "${WELL_KNOWN_REPOS[@]}"; do
        if [[ "$1" == *"$known_repo"* ]]; then
            return 0
        fi
    done
    return 1
}

# For Debian and Ubuntu
if grep -q 'ID=ubuntu\|ID=debian' /etc/os-release; then
    SOURCES=(/etc/apt/sources.list /etc/apt/sources.list.d/*.list)
# For Fedora
elif grep -q 'ID=fedora' /etc/os-release; then
    SOURCES=(/etc/yum.repos.d/*.repo)
# For CentOS
elif grep -q 'ID=centos' /etc/os-release; then
    SOURCES=(/etc/yum.repos.d/*.repo)
fi

# Loop through each source list or repo file
for source in "${SOURCES[@]}"; do
    while IFS= read -r line; do
        # Skip comments
        [[ "$line" =~ ^#.*$ ]] && continue 

        # Check for HTTP repositories
        if [[ "$line" == *"http://"* ]]; then
            echo "Warning: Insecure repository detected (HTTP): $line"
        fi

        # Check if the repository is well-known
        if ! is_well_known_repo "$line"; then
            echo "Warning: Unrecognized repository detected: $line"
        fi
    done < "$source"
done
