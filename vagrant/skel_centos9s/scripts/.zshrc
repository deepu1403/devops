# Set the default editor
export EDITOR=vim

# Set aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'

# Set PATH variable
export PATH=$HOME/bin:$PATH
export ZSH=~/.zsh

# Enable completion
autoload -Uz compinit; compinit; _comp_options+=(globdots)

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

# Enable history sharing between sessions
setopt SHARE_HISTORY

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

