#!/bin/bash
sudo usermod --password $(echo $CREDENTIAL_PASSWORD | openssl passwd -1 -stdin) --shell /bin/bash $CREDENTIAL_CORPORATE_ID
