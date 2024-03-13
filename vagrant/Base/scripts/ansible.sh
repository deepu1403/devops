#!/bin/bash

set -euxo pipefail

# Check if Ansible is installed
if command -v ansible &> /dev/null; then
    echo "Ansible is already installed."
else
    # Install Ansible
    echo "Installing Ansible"
    sudo dnf -y install ansible-core  # Use the appropriate package manager (e.g., apt, yum) based on your system
fi
