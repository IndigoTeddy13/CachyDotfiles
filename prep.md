# CachyOS

[Return to README](./README.md)

- Run the commands one by one in the repo's main directory
- Update non-pacman curl requests in case new versions come out

```bash
# Remove original dotfiles and symlink this repo's dotfiles (requires GNU Stow installed)
# Make the directories if they don't exist yet
stow --adopt dotfiles -t ~
```

```bash
# Update and upgrade pacman (default)
sudo pacman -Syu
```

```bash
# If using paru (https://aur.archlinux.org/packages/paru), or another AUR helper (look it up)
paru
```

```bash
# Add essential tools
# (git, fastfetch, python tools, crontab, etc)
sudo pacman -S git fastfetch python-pip pyenv python-pipx cronie sbctl cuda
paru -S pyenv-virtualenv powershell-bin
# Tutorial for creating virtual environments: https://github.com/pyenv/pyenv-virtualenv/issues/408#issuecomment-1644298267
```

```bash
# Install programming languages (Python and make are already installed)
# nodejs-lts-jod is NodeJS 22.x
sudo pacman -S rust lua go jdk-openjdk nodejs-lts-jod
```

```bash
# Useful for ASUS laptops with NVIDIA dGPUs
sudo pacman -S asusctl supergfxctl
```

```bash
# Install other tools and Nerd Fonts
sudo pacman -S libsixel docker docker-compose podman cmake neovim putty cargo-update zellij fzf eza bat ripgrep fd starship stow nerd-fonts otf-font-awesome ghostty chafa waydroid copyq
paru -S jetbrains-toolbox ttf-ms-fonts ttf-aptos ttf-vista-fonts ttf-tahoma fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-m17n ttf-sil-abyssinica blesh waypaper-git python-pywal16 matugen-bin
# If installing WezTerm instead of Ghostty, use `paru -S wezterm-nightly-bin` to work with Hyprland
```

```bash
# Also install tools to help with Hyprland
sudo pacman -S hyprland hypridle hyprlock hyprland-protocols wl-clipboard rofi waybar mako qt5ct qt6ct swww junction wlogout network-manager-applet blueman grimblast-git xdg-desktop-portal-hyprland xdg-desktop-portal-gtk gvfs libsecret gnome-keyring seahorse dconf-editor gnome-tweaks xorg-xeyes
paru -S gradia poweralertd xwaylandvideobridge
```

```bash
# Cool non-developer tools (not including FlatPaks)
sudo pacman -S ardour cava yt-dlp
```

```bash
# Install LazyGit, LazyDocker, air, gup, etc
go install github.com/jesseduffield/lazygit@latest \
&& go install github.com/jesseduffield/lazydocker@latest \
&& go install github.com/air-verse/air@latest \
&& go install github.com/nao1215/gup@latest \
&& go install honnef.co/go/tools/cmd/staticcheck@latest \
&& go install golang.org/x/tools/gopls@latest \
&& cargo install --git https://github.com/AlexKnauth/livesplit-one-druid
```

```bash
# Prevent FlatPak from installing the deprecated Breeze-Dark theme
sudo flatpak mask org.gtk.Gtk3theme.Breeze-Dark

# Use system themes
flatpak override --user ---filesystem=xdg-config/gtk-3.0:ro \
&& flatpak override --user --filesystem=xdg-config/gtk-4.0:ro \
&& flatpak override --user --filesystem=/home/$USER/.icons:ro \
&& flatpak override --user --filesystem=/home/$USER/.themes:ro \
&& flatpak override --user --filesystem=/usr/share/icons:ro \
&& flatpak override --user --filesystem=/usr/share/themes:ro
```
