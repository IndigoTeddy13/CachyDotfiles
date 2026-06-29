# Set Firefox to detect Wayland
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
    export GDK_BACKEND=wayland
fi

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Cargo config
export PATH="$HOME/.cargo/bin:$PATH"

# Config for installed Go binaries
export PATH="$(go env GOPATH)/bin:$PATH"

# SSH socket
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"

# Fcitx5 config
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx

