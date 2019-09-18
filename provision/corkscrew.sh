#!/bin/bash
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install corkscrew

sudo su $CREDENTIAL_CORPORATE_ID << 'EOF'
echo 'Host *
  ProxyCommand corkscrew 10.0.2.2 3128 %h %p
' > ~/.ssh/config
EOF
