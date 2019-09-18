#!/bin/bash
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install git

sudo GIT_USER_NAME="$GIT_USER_NAME" GIT_USER_EMAIL="$GIT_USER_EMAIL" su $CREDENTIAL_CORPORATE_ID << 'EOF'
git config --global user.name "$GIT_USER_NAME"
git config --global user.email $GIT_USER_EMAIL
EOF
