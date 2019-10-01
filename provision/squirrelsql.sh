#!/bin/bash
wget --no-verbose 'https://netix.dl.sourceforge.net/project/squirrel-sql/1-stable/4.0.0-plainzip/squirrelsql-4.0.0-standard.zip' -O /tmp/squirrelsql-4.0.0-standard.zip
sudo unzip /tmp/squirrelsql-4.0.0-standard.zip -d /opt/
sudo rm -rf /opt/squirrelsql
sudo mv /opt/squirrelsql-4.0.0-standard/ /opt/squirrelsql

sudo sh -s << 'EOF'
echo '[Desktop Entry]
Encoding=UTF-8
Name=SQuirreL SQL
Exec=java -jar /opt/squirrelsql/squirrel-sql.jar
Icon=/opt/squirrelsql/icons/acorn.png
Terminal=false
Type=Application
Categories=Development;
' > /usr/share/applications/squirrelsql.desktop
EOF

sudo su $CREDENTIAL_CORPORATE_ID << 'EOF'
mkdir ~/drivers
wget --no-verbose 'https://<DATABASE_DRIVER_FILE>' -O ~/drivers/<DATABASE_DRIVER_FILE>
EOF
