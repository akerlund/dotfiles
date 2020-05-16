# Git
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
sudo apt install xclip
git clone git@github.com:akerlund/dotfiles.git
```

# Vim
```bash
sudo apt install curl
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim
git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim
sudo apt install silversearcher-ag
```

# ifconfig
```bash
sudo apt install net-tools
```

# gtop
```bash
sudo apt install nodejs libnode64
sudo apt install npm
sudo npm install gtop -g
```

# Others
```bash
sudo apt install inkscape
sudo apt install pinta
sudo apt install irssi
sudo apt install nmap
```

# Vivado

```bash
sudo apt update
sudo apt install libtinfo-dev
sudo ln -s /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.5
sudo apt install libncurses5
```

# Gnome terminal

```bash
sudo apt install gnome-terminal
https://github.com/Mayccoll/Gogh
sudo apt install dconf-cli uuid-runtime
bash -c  "$(wget -qO- https://git.io/vQgMr)"
```

# Python

```bash
sudo apt install python3-pip
pip3 install numpy
```

# SSH

```bash
sudo apt install openssh-server
sudo systemctl status ssh
sudo ufw allow ssh
sudo systemctl start ssh
```

# p4merge

```bash
wget https://cdist2.perforce.com/perforce/r19.2/bin.linux26x86_64/p4v.tgz
tar zxvf p4v.tgz
sudo cp -r p4v-* /usr/local/p4v/
sudo ln -s /usr/local/p4v/bin/p4merge /usr/local/bin/p4merge
```

# Powerline fonts

```bash
sudo apt install fonts-powerline
```

# CentOS

```bash
https://www.centos.org/download/
lsblk # Find USB drive
sudo dd bs=4M if=CentOS-8.1.1911-x86_64-dvd1.iso of=/dev/sdb status=progress oflag=sync
```