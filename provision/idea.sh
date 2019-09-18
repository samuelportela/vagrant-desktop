#!/bin/bash
wget --no-verbose 'https://download-cf.jetbrains.com/idea/ideaIU-2019.2-no-jbr.tar.gz' -O /tmp/ideaIU-2019.2-no-jbr.tar.gz
sudo mkdir -p /opt/idea/idea-2019.2/
sudo tar -xf /tmp/ideaIU-2019.2-no-jbr.tar.gz -C /opt/idea/idea-2019.2/ --strip-components=1
sudo update-alternatives --install /usr/bin/idea idea /opt/idea/idea-2019.2/bin/idea.sh 2000

sudo sh -s << 'EOF'
echo '[Desktop Entry]
Version=1.0
Type=Application
Name=IntelliJ IDEA Ultimate Edition
Icon=/opt/idea/idea-2019.2/bin/idea.svg
Exec="/opt/idea/idea-2019.2/bin/idea.sh" %f
Comment=Capable and Ergonomic IDE for JVM
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-idea
' > /usr/share/applications/jetbrains-idea.desktop
EOF

sudo su $CREDENTIAL_CORPORATE_ID << 'EOF'
if [ -f ~/.local/share/applications/jetbrains-idea.desktop ]
then
    sudo rm ~/.local/share/applications/jetbrains-idea.desktop
fi
mkdir -p ~/.local/share/applications/
cp /usr/share/applications/jetbrains-idea.desktop ~/.local/share/applications/jetbrains-idea.desktop
EOF
