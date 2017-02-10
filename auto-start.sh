#!/bin/bash -x
if [ $USER != 'root' ]; then
    echo 'You should run this script using root.'
    exit 1
fi
cqUser=coolq
vncNumber=11
vncPort=59$vncNumber
cqHome=$( getent passwd "$cqUser" | cut -d: -f6 )
if [ "$cqAccount" == '' ]; then
    read -p 'Enter your bot QQ: ' cqAccount
fi
if [ "$cqAccount" == '' ]; then
    echo 'No account given.'
    exit 2
fi

sudo -u $cqUser mkdir -p $cqHome/.config/openbox
sudo -u $cqUser echo "$cqHome/cq /account $cqAccount" >> $cqHome/.config/openbox/autostart.sh
echo '[Unit]' > /etc/systemd/system/vnc-$cqUser.service
echo 'Description=Start x11vnc at startup.' >> /etc/systemd/system/vnc-$cqUser.service
echo 'After=multi-user.target' >> /etc/systemd/system/vnc-$cqUser.service
echo "User=$cqUser" >> /etc/systemd/system/vnc-$cqUser.service
echo '[Service]' >> /etc/systemd/system/vnc-$cqUser.service
echo 'Type=simple' >> /etc/systemd/system/vnc-$cqUser.service
echo "ExecStart=/usr/bin/Xvnc :$vncNumber -geometry 800x600 -depth 24 -rfbauth $cqHome/.vnc/sesman_${cqUser}_passwd -bs -ac -nolisten tcp -localhost -dpi 96" >> /etc/systemd/system/vnc-$cqUser.service
echo '[Install]' >> /etc/systemd/system/vnc-$cqUser.service
echo 'WantedBy=multi-user.target' >> /etc/systemd/system/vnc-$cqUser.service
