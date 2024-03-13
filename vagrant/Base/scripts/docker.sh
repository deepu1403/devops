#!/bin/bash
#
set -euxo pipefail

#sudo dnf update -y
        
# Install required dependencies
sudo dnf install -y yum-utils device-mapper-persistent-data lvm2
        
# Add Docker repository
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        
# Install Docker
sudo dnf install -y docker-ce docker-ce-cli containerd.io
        
# Enable and start Docker service
sudo systemctl enable --now docker

sudo usermod -aG docker vagrant
sudo usermod -aG docker ec2-user


sudo systemctl daemon-reload

newgrp docker