# Install Zsh
sudo yum install -y zsh wget git 

echo "vagrant ALL=(ALL:ALL) NOPASSWD: /usr/bin/chsh" | sudo EDITOR='tee -a' visudo

# Set Zsh as the default shell for the vagrant user
sudo chsh -s $(which zsh) vagrant
#sudo chsh -s $(/usr/bin/zsh) vagrant
sudo usermod -s /bin/zsh vagrant


# Copy the default .zshrc to the user's home directory
cp /vagrant/scripts/.zshrc /home/vagrant/

# Change ownership of the .zshrc file to the user
sudo chown vagrant:vagrant /home/vagrant/.zshrc

# Clone the zsh-autosuggestions repository from GitHub
sudo -u vagrant git clone https://github.com/zsh-users/zsh-autosuggestions /home/vagrant/.zsh/plugins/zsh-autosuggestions
sudo -u vagrant git clone https://github.com/zdharma-zmirror/fast-syntax-highlighting.git /home/vagrant/.zsh/plugins/fast-syntax-highlighting
sudo -u vagrant git clone https://github.com/zsh-users/zsh-completions.git /home/vagrant/.zsh/plugins/zsh-completions
sudo -u vagrant git clone --depth=1 https://github.com/woefe/git-prompt.zsh /home/vagrant/.zsh/plugins/git-prompt.zsh
sudo -u vagrant git clone --depth 1 https://github.com/junegunn/fzf.git /home/vagrant/.zsh/plugins/fzf

# Enable the plugins in the .zshrc file
echo 'source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> /home/vagrant/.zshrc
echo 'source ~/.zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> /home/vagrant/.zshrc
echo 'fpath=(~/.zsh/plugins/zsh-completions/src $fpath)' >> /home/vagrant/.zshrc
echo "source ~/.zsh/plugins/git-prompt.zsh/git-prompt.zsh" >> /home/vagrant/.zshrc
echo "source ~/.zsh/plugins/git-prompt.zsh/examples/pure.zsh" >> ~/.zshrc

sudo -u vagrant /home/vagrant/.zsh/plugins/fzf/install --all 


