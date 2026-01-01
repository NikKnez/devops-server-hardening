#!/bin/bash
# Create User with Sudo Access

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

read -p "Enter username: " USERNAME
read -p "Add SSH public key? (y/n): " ADD_KEY

# Create user
if ! id "$USERNAME" &>/dev/null; then
    adduser --disabled-password --gecos "" "$USERNAME"
    echo "✓ User $USERNAME created"
else
    echo "User $USERNAME already exists"
fi

# Add to sudo group
usermod -aG sudo "$USERNAME"
echo "✓ Added $USERNAME to sudo group"

# Setup SSH key if requested
if [[ "$ADD_KEY" == "y" ]]; then
    read -p "Paste SSH public key: " SSH_KEY
    
    mkdir -p /home/"$USERNAME"/.ssh
    echo "$SSH_KEY" > /home/"$USERNAME"/.ssh/authorized_keys
    chmod 700 /home/"$USERNAME"/.ssh
    chmod 600 /home/"$USERNAME"/.ssh/authorized_keys
    chown -R "$USERNAME":"$USERNAME" /home/"$USERNAME"/.ssh
    
    echo "✓ SSH key added for $USERNAME"
fi

echo "✓ User setup complete"
echo "Test sudo access: su - $USERNAME"
