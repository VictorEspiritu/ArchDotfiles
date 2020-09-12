#!/bin/bash


# =================== BOOT

# list Mount Point
lsblk

# list system file with size

df -h 

# Show size of a directory
du -sh /directory

# ==================== RESIZE HARD DISK 
# 1.- Increase Physics hard disk: from 20Gb to 60Gb
#     1.1- In VirtualBox execute command: VBoxManager --modifyhd 61440 /path/to/vdi   
# 2.- Expand Partition with cfdisk tool
#     2.1- Reboot OS or VM with ISO Arch in Live Mode Booteable (fisrt option) and list partition 
#     > lsblk
#       sda      8:0    0    60G  0 disk 
#       ├─sda1   8:1    0    15G  0 part 
#       └─sda2   8:2    0     5G  0 part 
#     2.2- Into Arch Live Mode execute command: cfdisk
#           2.2.1- Delete partition /dev/sda2 
#           2.2.2- Resize partition /dev/sda1 to 55G
#           2.2.3- Create partition /dev/sda2 in 5G
#           2.2.4- List partition
#               sda      8:0    0    60G  0 disk 
#               ├─sda1   8:1    0    55G  0 part 
#               └─sda2   8:2    0     5G  0 part
#           2.2.5- Update partition table with command: genfstab -U /mnt > /mnt/etc/fstab
#     2.3 Format new partition with command:>  mkfs.ext4 /dev/sda2
# 3.- Expand FileSystem and mount device 
#     3.1- Scand file and blocks with: e2fsck -f /dev/sda1 and  e2fsck -f /dev/sda2 
#     3.2- Resize filesystem with: resize2fs /dev/sda1 and resize2fs /dev/sda1
#     3.3- Create folder to mount: mkdir /mnt and mkdir /mnt/esev
#           3.3.1- Mount devices: mount /dev/sda1 /mnt and mount /dev/sda2 /mnt/esev 
#     3.4- list filesystem size with command: df -h
#           /dev/sda1         55G    13G   39G  26% /
#           /dev/sda2        4,9G    21M  4,6G   1% /esev
#     3.5- Change root in the new system and reboot OS with command: arch-chroot /mnt 

# ================== DISPLAY

# list resolution available with: > xrandr
# Modeline "1920x1080_59.88"  172.45  1920 2040 2248 2576  1080 1081 1084 1118  -HSync +Vsync
# command to list resolutions: > gtf 1360 768 60
# list output available: > find /sys/devices -name "edit"
# check output connect: > /sys/devices/pci............................../card0/card0-HDMI-A-1/status

# set full screen default

xrandr --newmode "1360x768_60.02" 84.74 1360 1424 1568 1776 768 769 772 795 -HSync +Vsync
xrandr --addmode Virtual-1 "1360x768_60.02" 
xrandr --output Virtual-1 --primary --mode "1360x768_60.02" --pos 0x0 --rotate normal


# =================== KEYBOARD

setxkbmap latam

#install rxvt-unicode
sudo pacman -S rxvt-unicode

#Run daemon rxvt and start client in ~/.xprofile
urxvtd -q -o -f 
urxvtc


# =================== Font size
git clone https://github.com/simmel/urxvt-resize-font.git

# ================== FONT
pacman -S ttf-ubuntu-font-family

# Create file .Xresources in ~/.Xresources with your customer terminal.
# with another config called: ~/.lynx.cfg and ~/.lynx.lss

#List Fonts
fc-list | grep "ubuntu"

#Install fonts
sudo pacman -S ttf-ubuntu-font-family
sudo pacman -S ttf-inconsolata
sudo pacman -S ttf-nerd-fonts-symbols
sudo pacman -S ttf-roboto-mono

#Install Font Icons
sudo pacman -S ttf-font-awesome 

#To extensions widget install gcc and psutil
sudo pacman -S gcc
pip install psutil

#Install NeoVim
#Install PluggedInstall Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#Install management wallpapers
sudo pacman -S feh
feh --bg-max ~/.Wallpapers/abstract.png

#Install PICOM, to composite manager in windows: to transparency
sudo pacman -S picom

#Install HTOP to list process
sudo pacman -S htop

#Install File Manager
sudo pacman -S ranger

#Configure default text editor to File Manager
export EDITOR=nvim;

#Install youtube viwer, configure ~/.config/youtube-viewer/user.json, with a new API_KEY and OAUTH (client_id, secret_id)
sudo pacman -S youtube-viewer

#Install VLC player
sudo pacman -S vlc

#Install audio util dow/up
sudo pacman -S alsa-utils

#add user to audio group
sudo gpasswd -a emerick audio

#enable audio
alsamixer

#Enable data share, so enable vbox enable and add own user to vboxsf
sudo systemctl enable vboxservice.service

#Add user to group vbox
sudo usermod -a -G vboxsf `whoami`

#Install lynx web browser 
sudo pacman -S lynx

#[deprecated]Install Chromium 
sudo pacman -S chromium

# [deprecated]Install sufr browser AUR respository
# 1 . git clone respository: https://aur.archlinux.org/surf.git
# 2 . cd into folder
# 3 . makepkg -si 
# 4 . [optional] install base libs before to makepkg: sudo pacman -S base-devel --needed

# Install browser web vimb
# 1. git clone git://github.com/fanglingsu/vimb.git
# 2. test software in sadbox: make runsandbox
# 3. build the software: sudo make install
# 4. configures styles and config:  nvim .config/vimb/config    ,  nvim .config/vimb/style.css
# 5 run: vimb


#For play youtube video in surf browser neet install this dependencies
sudo pacman -S gstreamer gst-plugins-good gst-libav

# Install dpf viewwer
# 1. install :  sudo pacman -S zathura-pdf-mupdf
# 2. downloand pdf in : ~/tmp
# 3. view pdf:  zathura tmp/CQRS_Journey_Guide.pdf
sudo pacman -S zathura-pdf-mupdf

#Install terminal info with neofetch, customize in: ~/.config/neofetch/config.conf
sudo pacman -S neofetch

#Add neofecth in start up bash
# 1. nvim ~/.bashrc and add: neofetch
# 2. reload: source ~/.neofetch


# Install Zsh and oh-my-zsh
# 1. install zsh: sudo pacman -S zsh
# 2. install oh-my-zsh:  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Install fonts git 
# git clone https://github.com/powerline/fonts.git --depth=1
# cd ..
# ./install.sh

# Add fonts to ~/.Xresource
URxvt.font: xft:DejaVu Sans Mono for Powerline:autohint=true:size=10, \

# In ~/.zshrc
# add prompt hack: prompt_context() {}

