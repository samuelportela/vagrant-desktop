#!/bin/bash
wget --no-verbose 'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US' -O /tmp/firefox.tar.bz2
sudo tar -xjf /tmp/firefox.tar.bz2 -C /opt/
sudo update-alternatives --install /usr/bin/firefox firefox /opt/firefox/firefox 2000

sudo sh -s << 'EOF'
echo '[Desktop Entry]
Name=Firefox
Comment=Web Browser
GenericName=Web Browser
X-GNOME-FullName=Firefox Web Browser
Exec=firefox %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/firefox/browser/chrome/icons/default/default128.png
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/htt$
StartupWMClass=Firefox
StartupNotify=true
' > /usr/share/applications/firefox-stable.desktop
EOF
