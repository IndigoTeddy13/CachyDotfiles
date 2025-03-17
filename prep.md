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
# (git, fastfetch, python tools, crontab)
sudo pacman -S git fastfetch python-pip pyenv python-virtualenv python-pipx cronie
paru pyenv-virtualenv
# Tutorial for creating virtual environments: https://github.com/pyenv/pyenv-virtualenv/issues/408#issuecomment-1644298267
```

```bash
# Install programming languages (Python and make are already installed)
sudo pacman -S rust lua go jdk-openjdk
```

```bash
# Install other tools and Nerd Fonts
sudo pacman -S bat fzf fd eza ripgrep libsixel docker docker-compose podman cmake neovim putty cargo-update zellij starship stow nerd-fonts ttf-ms-fonts ttf-aptos
paru -S jetbrains-toolbox ibus-m17n fcitx5 fcitx5-gtk fcitx5-qt fcitx5-m17n ttf-sil-abyssinica wezterm-git
```

```bash
# Install LazyGit, LazyDocker, air, gup, pywal, waypaper
go install github.com/jesseduffield/lazygit@latest \
&& go install github.com/jesseduffield/lazydocker@latest \
&& go install github.com/air-verse/air@latest \
&& go install github.com/nao1215/gup@latest \
&& pipx install pywal16 \
&& pipx install waypaper
```

```bash
# Install NVM and ble.sh via Paru
paru -S nvm blesh
```
