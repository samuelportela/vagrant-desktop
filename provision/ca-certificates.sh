#!/bin/bash
sudo su $CREDENTIAL_CORPORATE_ID << 'EOF'
mkdir ~/ca-certificates
wget --no-verbose 'https://<CORPORATE_CERTIFICATE_FILE>' -O ~/ca-certificates/CORPORATE_CERTIFICATE_FILE
wget --no-verbose 'https://<ANOTHER_CORPORATE_CERTIFICATE_FILE>' -O ~/ca-certificates/ANOTHER_CORPORATE_CERTIFICATE_FILE
EOF
