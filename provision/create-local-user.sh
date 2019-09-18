#!/bin/bash
sudo useradd -m $CREDENTIAL_CORPORATE_ID

sudo CREDENTIAL_CORPORATE_ID="$CREDENTIAL_CORPORATE_ID" sh -s << 'EOF'
echo "$CREDENTIAL_CORPORATE_ID ALL=(ALL) NOPASSWD:ALL
" > /etc/sudoers.d/$CREDENTIAL_CORPORATE_ID
EOF

sudo su $CREDENTIAL_CORPORATE_ID << 'EOF'
if [ ! -f ~/.ssh/id_rsa ]
then
    mkdir -p ~/.ssh/
    ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
fi
EOF
