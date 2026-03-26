# Fonts

Install JetBrains Mono Nerd Font system-wide so every user account can use it.
The files are placed under `/usr/local/share/fonts`, which is a global font directory.

`fc-cache -fv` is the important final step: it rebuilds the system font cache so apps can discover the new font immediately. Without refreshing the cache, the font may not appear until logout/restart.

If icons break when using SSH, remember fonts are rendered on the client machine (the computer running the terminal app), not on the remote host. Install/select a Nerd Font on that client as well.

```bash
sudo mkdir -p /usr/local/share/fonts/JetBrainsMonoNerd
cd /tmp && curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
sudo unzip -o JetBrainsMono.zip -d /usr/local/share/fonts/JetBrainsMonoNerd
sudo fc-cache -fv
```

# Starship

Install Starship to `/usr/local/bin` so it is available for all users.

```bash
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y -b /usr/local/bin
```

# CLI-tools via Cargo

Install a current Rust toolchain first (the `rustc`/`cargo` versions from apt are often too old for these crates), then install binaries into `/usr/local/bin` for all users.

```bash
sudo apt update
sudo apt install -y build-essential cmake pkg-config libssl-dev curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo sh -s -- -y --profile minimal --default-toolchain stable
sudo env PATH=/root/.cargo/bin:$PATH cargo install --locked --root /usr/local eza bat bottom du-dust ripgrep fd-find
```

# VIM

Install Pathogen and plugins system-wide in Vim's global runtime path so all users can use them.
Each user still needs `execute pathogen#infect()` in their own `~/.vimrc`.

```bash
sudo mkdir -p /usr/share/vim/vimfiles/autoload /usr/share/vim/vimfiles/bundle && \
sudo curl -LSso /usr/share/vim/vimfiles/autoload/pathogen.vim https://tpo.pe/pathogen.vim

sudo git clone https://github.com/nordtheme/vim.git /usr/share/vim/vimfiles/bundle/nord
sudo git clone https://github.com/vim-airline/vim-airline /usr/share/vim/vimfiles/bundle/vim-airline
sudo git clone https://github.com/vim-airline/vim-airline-themes /usr/share/vim/vimfiles/bundle/vim-airline-themes
```
