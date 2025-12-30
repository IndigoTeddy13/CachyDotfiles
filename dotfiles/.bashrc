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

# Apply aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Set Firefox to detect Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
    export GDK_BACKEND=wayland
fi

# Pywal config
cat ~/.cache/wal/sequences &

# Cargo config
export PATH="$HOME/.cargo/bin:$PATH"

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Config for installed Go binaries
export PATH="$(go env GOPATH)/bin:$PATH"

# Initialize ble.sh
[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach

# Intialize zoxide
eval "$(zoxide init bash)"

# Initialize Starship.rs
eval $(starship init bash)

# End later
[[ ! ${BLE_VERSION-} ]] || ble-attach
