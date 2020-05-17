#!/bin/bash

# ================== DISPLAY

# command to list resolutions: > gtf
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

#Icon wesomw:
clock: 
refresh:
main: 
net:
music:
code: 
git: 
cube: 
desktop: 
cube2: 
twitter: 
dragon: 
email: 
file: 
zip: 
image:
fire:
folder: 
huella:
font:
gema:
net-globo:
hard-disk:
headphones:
headphones2:
heart:
inbox:
image:
images:
infinity:
laptop:
laptop-code:
hoja:
microphone:
mobile:
phone:
play:
podcast:
terminal:
tv:
university:
wifi:
yinyang:










