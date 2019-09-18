#!/bin/bash
sudo apt-get install -y lvm2

sudo fdisk /dev/sda << EOF
d
5
d
2
d
n
p
1
2048
$[(DISK_SIZE_IN_GB - SWAP_SIZE_IN_GB) * 1024 * 2048 - 2048 - 1]
a
n
e
2


n


t
5
82
p
w
EOF

sudo sh -s << 'EOF'
echo '[Unit]
Description=Resize partitions service

[Service]
Type=oneshot
ExecStart=/bin/bash -c "swapoff /dev/sda5; resize2fs /dev/sda1; mke2fs -t ext4 -F /dev/sda5; tune2fs -U random /dev/sda5; mkswap /dev/sda5; sed -i -e \"/^UUID=.*swap/s#^UUID=[A-Fa-f0-9-]*#UUID=$(blkid -s UUID -o value /dev/sda5)#\" /etc/fstab; swapon /dev/sda5; systemctl disable resize-partitions"

[Install]
WantedBy=multi-user.target
' > /etc/systemd/system/resize-partitions.service
EOF

sudo systemctl enable resize-partitions
