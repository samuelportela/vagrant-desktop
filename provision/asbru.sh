#!/bin/bash
curl -s https://packagecloud.io/install/repositories/asbru-cm/asbru-cm/script.deb.sh | sudo bash
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install asbru-cm

sudo sh -s << 'EOF'
echo '[Desktop Entry]
Name=Ásbrú Connection Manager
Comment=Ásbrú Connection Manager is a user interface that helps organizing remote terminal sessions and automating repetitive tasks.
Terminal=false
Icon=asbru-cm
Type=Application
Exec=asbru-cm
StartupNotify=true
Categories=Utility;TerminalEmulator;GTK;Development;
X-GNOME-Autostart-enabled=false
Actions=Shell;Quick;ReadOnly;Tray;

[Desktop Action Shell]
Name=Start local shell
Exec=asbru-cm --start-shell

[Desktop Action Quick]
Name=Quick connect...
Exec=asbru-cm --quick-conn

[Desktop Action ReadOnly]
Name=Start Read-Only instance
Exec=asbru-cm --readonly --no-backup

[Desktop Action Tray]
Name=Start in system tray
Exec=asbru-cm --iconified
' > /usr/share/applications/asbru-cm.desktop
EOF
