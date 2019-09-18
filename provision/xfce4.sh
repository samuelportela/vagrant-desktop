#!/bin/bash
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install xfce4

sudo sh -c 'echo "deb http://ftp.debian.org/debian stretch-backports main contrib" > /etc/apt/sources.list.d/stretch-backports.list'
sudo apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get -y install virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 linux-headers-$(uname -r)
sudo VBoxClient --checkhostversion
sudo VBoxClient --clipboard
sudo VBoxClient --display
sudo VBoxClient --draganddrop
sudo VBoxClient --seamless
echo "$(whoami):$(whoami)" | sudo chpasswd
