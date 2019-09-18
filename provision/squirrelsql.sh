#!/bin/bash
wget --no-verbose 'https://kent.dl.sourceforge.net/project/squirrel-sql/1-stable/3.9.0-plainzip/squirrelsql-3.9.0-standard.zip' -O /tmp/squirrelsql-3.9.0-standard.zip
sudo unzip /tmp/squirrelsql-3.9.0-standard.zip -d /opt/
sudo mv /opt/squirrelsql-3.9.0-standard/ /opt/squirrelsql

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
