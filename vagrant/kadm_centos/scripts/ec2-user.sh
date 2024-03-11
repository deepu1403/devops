# Install Zsh
sudo yum install -y zsh wget git

# Create a new user named ec2-user
sudo useradd -m -s /bin/zsh ec2-user
    
# Set password for the user (replace 'password' with your desired password)
echo "password" | sudo passwd --stdin ec2-user
    
# Optionally, you can add the user to the sudoers file
echo "ec2-user ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/ec2-user

# Copy the default .zshrc to the user's home directory
cp /vagrant/scripts/.zshrc /home/ec2-user/
    
# Change ownership of the .zshrc file to the user
sudo chown ec2-user:ec2-user /home/ec2-user/.zshrc


# Clone the zsh-autosuggestions repository from GitHub
sudo -u ec2-user git clone https://github.com/zsh-users/zsh-autosuggestions /home/ec2-user/.zsh/plugins/zsh-autosuggestions
sudo -u ec2-user git clone https://github.com/zdharma-zmirror/fast-syntax-highlighting.git /home/ec2-user/.zsh/plugins/fast-syntax-highlighting
sudo -u ec2-user git clone https://github.com/zsh-users/zsh-completions.git /home/ec2-user/.zsh/plugins/zsh-completions
sudo -u ec2-user git clone --depth=1 https://github.com/woefe/git-prompt.zsh /home/ec2-user/.zsh/plugins/git-prompt.zsh
sudo -u ec2-user git clone --depth 1 https://github.com/junegunn/fzf.git /home/ec2-user/.zsh/plugins/fzf

# Enable the plugins in the .zshrc file
echo 'source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> /home/ec2-user/.zshrc
echo 'source ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> /home/ec2-user/.zshrc
echo 'fpath=(~/.zsh/plugins/zsh-completions/src $fpath)' >> /home/ec2-user/.zshrc
echo "source ~/.zsh/plugins/git-prompt.zsh/git-prompt.zsh" >> /home/ec2-user/.zshrc
echo "source ~/.zsh/plugins/git-prompt.zsh/examples/pure.zsh" >> ~/.zshrc

sudo -u ec2-user /home/ec2-user/.zsh/plugins/fzf/install --all 
