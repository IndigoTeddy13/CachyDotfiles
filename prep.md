# CachyOS

[Return to README](./README.md)

## Installation and Environment Variables:
- Run the commands one by one in the repo's main directory
- Update non-pacman curl requests in case new versions come out

```bash
# Remove original dotfiles and symlink this repo's dotfiles
# (requires GNU Stow installed)
# Make the directories if they don't exist yet
stow --adopt dotfiles -t ~
# Command to reinstall FlatPaks from a list (requires flatpak installed)
# (Also requires a backup list from "flatpak list --columns=application --app")
xargs flatpak install --or-update -y < ~/.config/flatpak-list.txt
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
sudo pacman -S git fastfetch git-filter-repo python-pip python-pipx flatpak cronie sbctl brightnessctl cachy-update cuda apparmor
paru -S miniconda3 powershell-bin
# For cachy-update systray (do once)
arch-update --tray --enable
systemctl --user enable --now arch-update-tray.service
# Tutorial for creating virtual environments: https://github.com/pyenv/pyenv-virtualenv/issues/408#issuecomment-1644298267
```

```bash
# Install programming languages (Python and make are already installed)
# nodejs-lts-jod is NodeJS 22.x
sudo pacman -S rust lua go jdk-openjdk jdk21-openjdk nodejs-lts-jod npm
```

```bash
# Useful for ASUS laptops with NVIDIA dGPUs
sudo pacman -S asusctl supergfxctl
```

```bash
# Install other tools and Nerd Fonts
sudo pacman -S libsixel docker docker-compose podman cmake neovim putty cargo-update zellij fzf eza bat ripgrep fd starship stow nerd-fonts otf-font-awesome ghostty chafa waydroid copyq
paru -S jetbrains-toolbox ttf-ms-fonts ttf-aptos ttf-vista-fonts ttf-tahoma ttf-sil-abyssinica fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-m17n blesh python-pywal16 vscodium-bin
# If installing WezTerm instead of Ghostty, use `paru -S wezterm-nightly-bin` to work with Hyprland
```

```bash
# Also install tools to help with Hyprland
sudo pacman -S hyprland hypridle hyprlock hyprpicker hyprland-protocols wl-clipboard xclip xsel rofi waybar mako qt5ct qt6ct swww junction wlogout network-manager-applet blueman grimblast-git xdg-desktop-portal-hyprland xdg-desktop-portal-gtk gvfs dconf-editor gnome-tweaks xorg-xeyes xorg-xev archlinux-xdg-menu
paru -S poweralertd xwaylandvideobridge
```

```bash
# Cool non-developer tools (not including FlatPaks)
sudo pacman -S ardour cava yt-dlp

# Wallpaper pakcages
paru -S plasma-workspace-wallpapers archlinux-wallpaper cachyos-wallpapers
```

```bash
# Install LazyGit, LazyDocker, air, gup, etc
go install github.com/jesseduffield/lazygit@latest \
&& go install github.com/jesseduffield/lazydocker@latest \
&& go install github.com/air-verse/air@latest \
&& go install github.com/nao1215/gup@latest \
&& go install honnef.co/go/tools/cmd/staticcheck@latest \
&& go install golang.org/x/tools/gopls@latest \
&& cargo install --git https://github.com/AlexKnauth/livesplit-one-druid \
&& pipx install waypaper # pywal16
```

```bash
# Prevent FlatPak from installing the deprecated Breeze-Dark theme
sudo flatpak mask org.gtk.Gtk3theme.Breeze-Dark

# Use system themes
flatpak override --user --filesystem=xdg-config/gtk-3.0:ro \
&& flatpak override --user --filesystem=xdg-config/gtk-4.0:ro \
&& flatpak override --user --filesystem=/home/$USER/.icons:ro \
&& flatpak override --user --filesystem=/home/$USER/.themes:ro \
&& flatpak override --user --filesystem=/usr/share/icons:ro \
&& flatpak override --user --filesystem=/usr/share/themes:ro

# Remember to set $XDG_SESSION_TYPE=x11 for Electron-based FlatPaks that don't have proper screenshare on Wayland (Discord, Slack, etc)
```

## Global Configs

```bash
# Edit /usr/share/themes/default/index.theme to use the desired theme
[Icon Theme]
Inherits=Breeze
```

```bash
# Add to /etc/NetworkManager/NetworkManager.conf for MAC randomization 
[device]
wifi.scan-rand-mac-address=yes

[connection]
wifi.cloned-mac-address=random
ethernet.cloned-mac-address=random
```

```bash
# Add these lines to /etc/pam.d/login and /etc/pam.d/sddm to get kwallet6 working on any DE/WM
# Also for independent WMs, might need to exec-once "/usr/lib/pam_kwallet_init" and "kwalletd6"
auth       optional    pam_kwallet5.so
session    optional    pam_kwallet5.so auto_start
```

```bash
# Add to KERNEL_CMDLINE for your bootloader, along with enabling the apparmor service
lsm=landlock,lockdown,yama,integrity,apparmor,bpf
```
