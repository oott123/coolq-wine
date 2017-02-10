#!/bin/bash -xe
echo '* Unziping CoolQ ...'
cd ~/cqzip
LC_ALL=zh_CN.UTF-8 unzip *.zip
mkdir ~/coolq
mv */* ~/coolq
cd ~
rm -rf ~/cqzip
echo '* Setting up prefix ...'
export WINEPREFIX=~/coolqprefix
mkdir $WINEPREFIX
if [ -f prefix.tar.gz ]; then
    tar xvf prefix.tar.gz -C $WINEPREFIX
else
    winetricks winhttp
    winetricks msscript
    winetricks cjkfonts
fi
echo '* Creating start script ...'
touch cq
chmod +x ./cq
echo '#!/bin/bash' > cq
echo "export WINEPREFIX=$WINEPREFIX" >> cq
echo 'export LC_CTYPE=zh_CN.UTF-8' >> cq
echo 'wine ~/coolq/CQ?.exe $@' >> cq
echo 'exec openbox-session' > ~/.xsession