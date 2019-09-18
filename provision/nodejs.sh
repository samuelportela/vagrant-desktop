#!/bin/bash
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install nodejs

sudo su $CREDENTIAL_CORPORATE_ID << 'EOF'
npm config set strict-ssl false
npm config set registry http://registry.npmjs.org
npm config set maxsockets 3
EOF

sudo sh -s << 'EOF'
echo 'export NODE_TLS_REJECT_UNAUTHORIZED=0
' >> /etc/environment
EOF
