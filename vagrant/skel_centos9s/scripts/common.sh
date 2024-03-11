#!/bin/bash
#
# Common setup for all servers (Control Plane and Nodes)

set -euxo pipefail

# Update the system
echo "[TASK 1] Updating the system"
#yum update -y 

# Enable password authentication
echo "[TASK 2] Enabling password authentication in sshd config"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Disable SELinux
echo "[TASK 3] Disable SELinux"
#sudo echo 0 > /selinux/enforce
#setenforce 0
#/usr/sbin/setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Disable and stop firewalld
echo "[TASK 5] Disable and stop firewalld"
sudo systemctl disable firewalld 
#>/dev/null 2>&1
sudo systemctl stop firewalld

# Variable Declaration


# Install systemd-resolved
echo "[TASK 6] Install systemd-resolved"
sudo yum install -y systemd-resolved 
#>/dev/null 2>&1

# Enable and start systemd-resolved
sudo systemctl enable systemd-resolved
sudo systemctl start systemd-resolved

# Update /etc/nsswitch.conf
#sudo sed -i '/^hosts:/ s/dns$/dns resolve/' /etc/nsswitch.conf
sudo sed -i '/^hosts:/ s/dns myhostname\( \)*$/dns resolve\1/' /etc/nsswitch.conf


# Restart networking
sudo systemctl restart NetworkManager

# DNS Setting
if [ ! -d /etc/systemd/resolved.conf.d ]; then
	sudo mkdir /etc/systemd/resolved.conf.d/
fi
cat <<EOF | sudo tee /etc/systemd/resolved.conf.d/dns_servers.conf
[Resolve]
DNS=${DNS_SERVERS}
EOF

sudo systemctl restart systemd-resolved

# Check if the environment variable is set
if [ -n "$ANSIBLE" ]; then
    echo "Installing Ansible Core"
    sudo dnf -y install ansible-core
else
    echo "The environment variable MY_ENV_VARIABLE is not set. No action taken."
fi

#ANS_VERSION="$(echo ${ANSIBLE_VERSION} | grep -oE '[0-9]+\.[0-9]+')"

#sudo dnf -y install "ansible-core-${ANS_VERSION}"

