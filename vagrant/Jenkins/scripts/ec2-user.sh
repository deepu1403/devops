# Install Zsh
sudo yum install -y zsh wget git glibc cargo tmux

# Create a new user named ec2-user
sudo useradd -m -s /usr/bin/zsh ec2-user

#sudo chsh -s $(which zsh) ec2-user
#sudo chsh -s $(/usr/bin/zsh) ec2-user
    
# Set password for the user (replace 'password' with your desired password)
echo "welcome" | sudo passwd --stdin ec2-user
    
# Optionally, you can add the user to the sudoers file
echo "ec2-user ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/ec2-user
#echo "vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/vagrant

# Copy the default .zshrc to the user's home directory
echo '
# Set the default editor
export EDITOR=vim

# Example configuration in ~/.zshrc
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTCONTROL=ignoreboth:erasedups


# Set aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias shq="fc -ln 0 > /vagrant/scripts/.zsh_history && fc -ln 0 >> ~/.zsh_history"
alias exit="shq && exit"

# Set PATH variable
export PATH=$HOME/bin:/usr/local/nvim/bin:$PATH
export ZSH=~/.zsh

# Enable completion
autoload -Uz compinit; _comp_options+=(globdots)

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

# Enable history sharing between sessions
setopt SHARE_HISTORY

# Enable ignore duplicates in history
setopt HIST_IGNORE_ALL_DUPS

# Disable Recording History Timestamps
#setopt HIST_STAMPS

# Enable case-insensitive tab completion
setopt NOCASEGLOB

# Enable recursive globbing
#setopt GLOBSTAR

# Customize key bindings (example)
bindkey '^R' history-incremental-search-backward

# Load additional configurations from ~/.zshrc.local if it exists
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi


# Define colors
autoload -U colors
colors

# Set prompt format
PS1="%F{blue}%n@%m %F{green}%~ %F{yellow}%# %f"
' > /home/ec2-user/.zshrc

sudo -u ec2-user cp /vagrant/scripts/.zsh_history /home/ec2-user/.zsh_history

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

#Install Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz 
sudo tar -xvf nvim-linux64.tar.gz -C /usr/local/ >/dev/null 2>&1
sudo mv /usr/local/nvim-linux64 /usr/local/nvim

#install Lazyvim
sudo rm -rf /home/ec2-user/.config/nvim/.git
sudo -u ec2-user git clone https://github.com/LazyVim/starter /home/ec2-user/.config/nvim