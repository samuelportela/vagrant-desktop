#!/bin/bash
wget --no-verbose 'https://dl.pstmn.io/download/latest/linux64' -O /tmp/postman.tar.gz
sudo mkdir -p /opt/postman/
sudo tar -xf /tmp/postman.tar.gz -C /opt/postman/ --strip-components=1
sudo update-alternatives --install /usr/bin/postman postman /opt/postman/Postman 2000

sudo sh -s << 'EOF'
echo '[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
' > /usr/share/applications/postman.desktop
EOF
