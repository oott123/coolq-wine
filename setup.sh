#!/bin/bash -xe
cqUser=coolq
echo '* Prepare add-apt-repository ...'
apt-get install -y software-properties-common python-software-properties python3-software-properties
echo '* Add wine ppa ...'
add-apt-repository -y ppa:wine/wine-builds
apt-get update
echo '* Add 32 arch support ...'
dpkg --add-architecture i386
echo '* Install requirements ...'
apt-get install -y xorg openbox xrdp cabextract unzip language-pack-zh-hans
echo '* Install wine ...'
apt-get install -y --install-recommends winehq-devel
echo '* Install winetricks ...'
wget -O /usr/local/bin/winetricks https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod 755 /usr/local/bin/winetricks
echo '* Setting up user ...'
adduser --disabled-password --gecos "" $cqUser
cqHome=$( getent passwd "$cqUser" | cut -d: -f6 )
if [ -f ./prefix.tar.gz ]; then
    cp ./prefix.tar.gz $cqHome/prefix.tar.gz
    chown $cqUser:$cqUser $cqHome/prefix.tar.gz
fi
echo '* Downloading CoolQ ...'
if [ "$CQURL" == '' ]; then
    CQURL=http://dlsec.cqp.me/cqa-tuling
fi
wget -O ./coolq.zip $CQURL
mkdir $cqHome/cqzip
cp ./coolq.zip $cqHome/cqzip
chown -R $cqUser:$cqUser $cqHome/cqzip
cat ./setup-user.sh | sudo -Hu $cqUser bash -xe
echo "* Set password for $cqUser ..."
passwd $cqUser
echo <<EOF
CoolQ on wine is now avaliable via rdp.
Please connect it using mstsc.
EOF