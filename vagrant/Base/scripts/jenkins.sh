#!/bin/bash
#
#set -euxo pipefail

# Install Java
sudo dnf install -q -y java-17-openjdk-devel

# Install Jenkins
#sudo dnf install -y wget
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf install -q -y jenkins

# Start Jenkins service
#sudo systemctl start jenkins
#sudo systemctl enable jenkins
sudo systemctl enable --now jenkins


# wait for initialization to finish.
bash -c 'while [ ! -f "/var/lib/jenkins/secrets/initialAdminPassword" ]; do sleep 1; done'
     
echo "Jenkins Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
