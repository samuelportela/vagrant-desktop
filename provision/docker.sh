#!/bin/bash
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install docker-ce
sudo mkdir -p /etc/systemd/system/docker.service.d

sudo sh -s << 'EOF'
echo '[Service]
Environment="HTTP_PROXY=http://10.0.2.2:3128"
Environment="HTTPS_PROXY=http://10.0.2.2:3128"
Environment="FTP_PROXY=http://10.0.2.2:3128"
Environment="NO_PROXY=localhost,127.0.0.1"
Environment="NODE_TLS_REJECT_UNAUTHORIZED=0"
' > /etc/systemd/system/docker.service.d/http-proxy.conf
EOF

sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl restart docker
sudo usermod --groups docker --append $CREDENTIAL_CORPORATE_ID

sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
