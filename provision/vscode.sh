#!/bin/bash
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install libgconf-2-4
wget --no-verbose 'https://go.microsoft.com/fwlink/?LinkID=760868' -O /tmp/vscode.deb
sudo dpkg -i /tmp/vscode.deb
