#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Don't duplicate lines in history by forcing "ignoredups" and "ignorespace"
HISTCONTROL=ignoredups:ignorespace

# Append to history file, don't overwrite it
shopt -s histappend

# Set "HISTSIZE" and "HISTFILESIZE"
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and update "LINES" and "COLUMNS", as needed    
shopt -s checkwinsize

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
eval "$(zoxide init bash)"

# Initialize Starship.rs
eval $(starship init bash)

# Custom color sequences
# (cat ~/.cache/wal/sequences &) 2>/dev/null
