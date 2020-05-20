# Debian Installation Guide

## Git
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
sudo apt install xclip
git clone git@github.com:akerlund/dotfiles.git
```

## Vim
```bash
sudo apt install curl
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim
git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim
sudo apt install silversearcher-ag
```

## ifconfig
```bash
sudo apt install net-tools
```

## gtop
```bash
sudo apt install nodejs libnode64
sudo apt install npm
sudo npm install gtop -g
```

## Others
```bash
sudo apt install inkscape
sudo apt install pinta
sudo apt install irssi
sudo apt install nmap
```

## Vivado

```bash
sudo apt update
sudo apt install libtinfo-dev
sudo ln -s /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.5
sudo apt install libncurses5
```

## Gnome terminal

```bash
sudo apt install gnome-terminal
https://github.com/Mayccoll/Gogh
sudo apt install dconf-cli uuid-runtime
bash -c  "$(wget -qO- https://git.io/vQgMr)"
```

## Python

```bash
sudo apt install python3-pip
pip3 install numpy
```

## SSH

```bash
sudo apt install openssh-server
sudo systemctl status ssh
sudo ufw allow ssh
sudo systemctl start ssh
```

## p4merge

```bash
wget https://cdist2.perforce.com/perforce/r19.2/bin.linux26x86_64/p4v.tgz
tar zxvf p4v.tgz
sudo cp -r p4v-* /usr/local/p4v/
sudo ln -s /usr/local/p4v/bin/p4merge /usr/local/bin/p4merge
sudo ln -s /usr/local/p4v/bin/p4merge /usr/bin/p4merge

```

## Powerline fonts

```bash
sudo apt install fonts-powerline
```

# CentOS Installation GUide

## Installation USB
```bash
https://www.centos.org/download/
lsblk # Find USB drive
sudo dd bs=4M if=CentOS-8.1.1911-x86_64-dvd1.iso of=/dev/sdb status=progress oflag=sync
```

## Xclip
```bash
sudo yum install epel-release.noarch
sudo yum install xclip
```

## Visual Studio Code
Create this file
```bash
vim /etc/yum.repos.d/vscode.repo
```
and add this
```bash
[vscode]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
```
and then just
```bash
sudo yum check-update
sudo yum install code
```

## TigerVNC

Probably an incomplete guide, but these notes are basically what I did to enable TigerVNC

### Install
```
dnf install tigervnc-server tigervnc-server-module -y
sudo dnf groupinstall "Server with GUI"
vncpasswd
```

### Firewall

```bash
firewall-cmd --permanent --add-port=5901/tcp # For each user, 5902, 5903 ...
firewall-cmd --reload
firewall-cmd --list-services
```

### Configuring VNC Server

Create the xstartup file:

```
touch ~/.vnc/xstartup
chmod 775 ~/.vnc/xstartup
vim ~/.vnc/xstartup
```

and add this configuration

```bash
#!/bin/sh
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
vncconfig -iconic &
dbus-launch --exit-with-session gnome-session &
```

### Systemd unit file

Copy example service file and edit it

```bash
mkdir -p ~/.config/systemd/user
sudo cp /usr/lib/systemd/user/vncserver@.service ~/.config/systemd/user/vncserver@.service
sudo vim ~/.config/systemd/user/vncserver@.service
```

This should work

```
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking

ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/bin/vncserver %i 
ExecStop=/usr/bin/vncserver -kill %i

Restart=on-success
RestartSec=15

[Install]
WantedBy=default.target
```

```bash
systemctl --user daemon-reload
systemctl --user enable vncserver@:1.service --now
loginctl enable-linger
systemctl --user status vncserver@:1.service
```

## GCC

```bash
sudo dnf group install "Development Tools"
```

## gtop

```bash
yum install epel-release
yum install nodejs
npm install gtop -g
```

## powerline

```bash
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
```

## Vivado

Some tricks that are needed to get 2019.2 working as it should

```bash
sudo ln -s /lib64/libtinfo.so.6 /lib64/libtinfo.so.5
sudo ln -s /usr/lib64/libncurses.so.6 /usr/lib64/libncurses.so.5
```

## GNU Octave

```bash
sudo dnf config-manager --set-enabled PowerTools
sudo yum install octave
```
