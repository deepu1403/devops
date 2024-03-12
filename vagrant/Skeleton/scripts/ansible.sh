# Check if the environment variable is set
if [ -n "$ANSIBLE" ]; then
    echo "Installing Ansible Core"
    sudo dnf -y install ansible-core
else
    echo "The environment variable MY_ENV_VARIABLE is not set. No action taken."
fi

#ANS_VERSION="$(echo ${ANSIBLE_VERSION} | grep -oE '[0-9]+\.[0-9]+')"

#sudo dnf -y install "ansible-core-${ANS_VERSION}"
sudo dnf -y install ansible-core