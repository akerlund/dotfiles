# Fonts

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv
```

# Starship

```bash
curl -sS https://starship.rs/install.sh | sh
```

# CLI-tools via Cargo

```bash
sudo apt update
sudo apt install -y build-essential cmake pkg-config libssl-dev
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
cargo install eza bat bottom du-dust ripgrep fd-find
```

# VIM

```bash
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.ssh/pathogen.vim https://tpo.pe/pathogen.vim && \
mv ~/.ssh/pathogen.vim ~/.vim/autoload/

git clone https://github.com/nordtheme/vim.git ~/.vim/bundle/nord
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
```
