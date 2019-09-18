#!/bin/bash
sudo su - $CREDENTIAL_CORPORATE_ID
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install vim

sudo su $CREDENTIAL_CORPORATE_ID << 'EOF'
touch ~/.bashrc
echo "export EDITOR=vim" >> ~/.bashrc
EOF
