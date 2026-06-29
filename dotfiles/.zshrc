# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/indigo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Add paths
if [ -f ~/.profile ]; then
    source ~/.profile
fi

# Apply aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Initialize NVM (Node Version Manager)
source /usr/share/nvm/init-nvm.sh

# Intialize zoxide
eval "$(zoxide init zsh)"

# Intialize Starship.rs
eval "$(starship init zsh)"

# Enable plugins (Arch Linux paths)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Custom color sequences
(cat ~/.cache/sequences &) 2>/dev/null
