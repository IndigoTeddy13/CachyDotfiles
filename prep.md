# CachyOS

[Return to README](./README.md)

## Installation and Environment Variables:
- Run the commands one by one in the repo's main directory
- Update non-pacman curl requests in case new versions come out

```bash
# Remove original dotfiles and symlink this repo's dotfiles
# (requires GNU Stow installed)
# Make the directories if they don't exist yet
stow dotfiles -t ~
# If you want to use your existing configurations, adopt them instead
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
# (git, fastfetch, python tools, etc)
sudo pacman -S git git-filter-repo fastfetch python-pip python-pipx python-pygments flatpak sbctl cachy-update sniffnet apparmor dnscrypt-proxy keepassxc
paru -S miniconda3
# For cachy-update systray (do once)
arch-update --tray --enable
systemctl --user enable --now arch-update-tray.service
```


```bash
# Install programming languages (Python and make are already installed)
# nodejs-lts-jod is NodeJS 22.x
sudo pacman -S rust cargo-update cargo-binstall lua go gopls staticcheck jdk-openjdk jdk25-openjdk nvm
# Install tooling for Linux KVM
sudo pacman -S qemu-full virt-manager swtpm
# Tutorial for setting up https://wiki.cachyos.org/virtualization/qemu_and_vmm_setup/)
```

```bash
# Useful for ASUS laptops
sudo pacman -S rog-control-center
```

```bash
# Install other dev tools
sudo pacman -S docker docker-compose podman podman-compose cmake neovim putty zellij tree fzf eza bat ripgrep fd zoxide starship lazygit lazydocker stow kitty matugen code waydroid copyq helium-browser-bin
# If installing WezTerm, use `paru -S wezterm-nightly-bin` to work with Hyprland
# Had personal issues with sudo not working on Ghostty on my setup, but use `sudo pacman -S ghostty` to see whether you have any issues
```

```bash
# Install local LLM tooling (make sure to install for your respective hardware, ie: ollama-vulkan, ollama-rocm, etc)
# ollama-cuda pulls CUDA as a dependency
sudo pacman -S ollama-cuda
# Make sure to enable the ollama.service, or run `ollama.serve` in autostart
# Accompanying model
ollama pull qwen3-vl:4b-instruct 
# Podman-compatible installation instructions for Open WebUI on port 13579 (might switch to another UI in the future)
# podman run -d --name openwebui -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://localhost:11434 -e PORT=13579 --network=host ghcr.io/open-webui/open-webui:main
```

```bash
# Install Nerd Fonts and fcitx5 
sudo pacman -S nerd-fonts otf-font-awesome fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool fcitx5-m17n
```

```bash
# Install GNOME and other GTK tools
sudo pacman -S gnome gdm-settings gnome-tweaks gnome-shell-extensions extension-manager seahorse xdg-desktop-portal-gtk
# GVfs-specific tools
sudo pacman -S gvfs gvfs-afc gvfs-dnssd gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb gvfs-wsdd
# Install KDE tools
sudo pacman -S breeze breeze-gtk breeze-cursors ocean-sound-theme qt5-wayland qt6-wayland polkit-kde-agent 
# Install Hyprland and relevant tools
sudo pacman -S hyprland hypridle hyprpicker hyprland-protocols xdg-desktop-portal-hyprland
# Install MangoWM
sudo pacman -S mangowm xwayland-satellite xdg-desktop-portal-wlr
# Install relevant underlying tools
sudo pacman -S swaybg wl-clipboard wtype rofi rofimoji qt5ct qt6ct brightnessctl playerctl grimblast-git
# paru -S swayidle sway-audio-idle-inhibit-git
# Also install topbar/panel tools
sudo pacman -S noctalia-shell
# Also install X11/XWayland tools
sudo pacman -S xclip xsel xdotool xorg-xev xorg-xeyes
```

```bash
# Cool non-developer tools (not including FlatPaks)
# yt-dlp installs deno as a dependency
sudo pacman -S cava mpv yt-dlp

# Wallpaper pakcages
sudo pacman -S plasma-workspace-wallpapers archlinux-wallpaper cachyos-wallpapers
```

```bash
# Install air, gup, etc
# go install github.com/air-verse/air@latest && \
# go install github.com/nao1215/gup@latest && \
# pipx install waypaper

# Install LiveSplit.exe via Bottles (relevant tutorial: https://youtu.be/4H6MF3baAcw)
```

```bash
# For brightness management on GNOME/GDM, to increment brightness by 5 (like other DEs/WMs)
# Disable default brightness keybinds:
gsettings set org.gnome.shell.keybindings screen-brightness-up "['']"
gsettings set org.gnome.shell.keybindings screen-brightness-down "['']"

# Rebind targets:
PATH_UP="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
PATH_DOWN="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"

# Rebind Brightness Increase:
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH_UP name "Brightness Up 5"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH_UP command "brightnessctl set 5%+"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH_UP binding "XF86MonBrightnessUp"

# Rebind Brightness Decrease:
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH_DOWN name "Brightness Down 5"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH_DOWN command "brightnessctl set 5%-"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$PATH_DOWN binding "XF86MonBrightnessDown"

# Reregister shortcuts:
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$PATH_UP', '$PATH_DOWN']"
```

```bash
# Prevent FlatPak from installing the deprecated Breeze-Dark theme
sudo flatpak mask org.gtk.Gtk3theme.Breeze-Dark

# Use system themes
flatpak override --user --filesystem=xdg-config/gtk-3.0:ro && \
flatpak override --user --filesystem=xdg-config/gtk-4.0:ro && \

# Remember to set $XDG_SESSION_TYPE=x11 for Electron-based FlatPaks that don't have proper screenshare on Wayland (Discord, Slack, etc)
# Likewise, set $XDG_SESSION_TYPE=x11 and $QT_QPA_PLATFORM=xcb for OBS Studio to regain X11 popup functionality under XWayland

# Edit argv.json for VS Code/Codium (Preferences: Configure Runtime Arguments) to include:
{"password-store":"gnome-libsecret"}

# Give Bottles access to specific directories
flatpak override --user --filesystem=home:ro com.usebottles.bottles && \
flatpak override --user --filesystem=xdg-data/applications:create com.usebottles.bottles && \
flatpak override --user --filesystem="/home/indigo/PersonalCodeProjects/IndigoTeddyPBs" com.usebottles.bottles
```

## Global Configs

```bash
# Edit /usr/share/themes/default/index.theme to use the desired theme
[Icon Theme]
Inherits=Breeze
```

```bash
# Edit /etc/environment to include the correct environment variables for fcitx5
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
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
# Add these lines to /etc/pam.d/login and /etc/pam.d/sddm (or equivalent) to get kwallet6 working on any DE/WM
# Also for independent WMs, might need to exec-once "/usr/lib/pam_kwallet_init" and "kwalletd6"
auth       optional    pam_kwallet5.so
session    optional    pam_kwallet5.so auto_start
# Likewise for GNOME Keyring
# For independent WMs, might need to exec-once "gnome-keyring-daemon --start --components=secrets,ssh,pkcs11"
auth       optional     pam_gnome_keyring.so
session    optional     pam_gnome_keyring.so auto_start
```

```bash
# Create, enable, and start the following service as /etc/systemd/system/power-profile-pre-login.service to launch power-saving mode before login
[Unit]
Description=Set Power Profiles before Display Manager
Requires=power-profiles-daemon.service
After=power-profiles-daemon.service
Before=graphical.target
Before=display-manager.service

[Service]
Type=oneshot
ExecStart=/usr/bin/powerprofilesctl set power-saver

[Install]
WantedBy=multi-user.target
```

```bash
# Add to KERNEL_CMDLINE for your bootloader, along with enabling the apparmor service
lsm=landlock,lockdown,yama,integrity,apparmor,bpf
```

```bash
# Add to `/etc/modprobe.d/audio-powersave.conf` to force hardware to a low-power state after pipewire/wireplumber demands it
options snd_hda_intel power_save=1
```

```bash
# Add/edit the following lines in the appropriate sections of `/etc/dnscrypt-proxy/dnscrypt-proxy.toml`

### Anonymized DNS ###
[anonymized_dns]
skip_incompatible = true

routes = [
    { server_name='*', via=['*'] }
]

### Connection Settings ###
http3 = true
```

```bash
# Add this to `/etc/NetworkManager/conf.d/00-use-local-dns.conf`
[main]
dns=none
systemd-resolved=false

# And delete and replace `/etc/resolv.conf` with this
nameserver 127.0.0.1
nameserver ::1
options edns0
```
