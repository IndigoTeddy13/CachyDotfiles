# CachyOS

[Return to README](./README.md)

- Run the commands one by one in the repo's main directory
- Update non-pacman curl requests in case new versions come out

```bash
# Remove original dotfiles and symlink this repo's dotfiles
# Make the directories if they don't exist yet
sudo ln -s -f $PWD/dotfiles/.bashrc ~/.bashrc \
&& sudo ln -s -f $PWD/dotfiles/.bash_profile ~/.bash_profile \
&& sudo ln -s -f $PWD/dotfiles/.bash_aliases ~/.bash_aliases \
&& sudo ln -s -f $PWD/dotfiles/.gitconfig ~/.gitconfig \
&& sudo ln -s -f  $PWD/dotfiles/.hushlogin ~/.hushlogin \
&& sudo ln -s -f $PWD/dotfiles/.config/starship.toml ~/.config/starship.toml \
&& sudo ln -s -f $PWD/dotfiles/.wezterm.lua ~/.wezterm.lua
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
# Add essential tools (git, fastfetch, python-pip)
sudo pacman -S git fastfetch python-pip
```

```bash
# Install programming languages (Python and make are already installed)
sudo pacman -S rust lua go jdk-openjdk
```

```bash
# Install other tools and Nerd Fonts
sudo pacman -S bat fzf fd eza ripgrep libsixel docker docker-compose podman cmake neovim putty wezterm zellij nerd-fonts ttf-ms-fonts ttf-aptos
paru -S jetbrains-toolbox ibus-m17n ttf-sil-abyssinica
```

```bash
# Install LazyGit, LazyDocker, btop, starship.rs, eza, zoxide
go install github.com/jesseduffield/lazygit@latest \
&& go install github.com/jesseduffield/lazydocker@latest \
&& go install github.com/air-verse/air@latest \
&& go install github.com/nao1215/gup@latest \
&& cargo install starship --locked \
&& cargo install cargo-update
```

```bash
# Install NVM and ble.sh via Paru
paru -S nvm blesh
```
