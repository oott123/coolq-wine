#!/bin/bash -xe
echo '* Unziping CoolQ ...'
cd ~/cqzip
LC_ALL=zh_CN.UTF-8 unzip *.zip
mkdir ~/coolq
mv */* ~/coolq
cd ~
rm -rf ~/cqzip
echo '* Setting up prefix ...'
mkdir ~/coolqprefix
export WINEPREFIX=~/coolqprefix
winetricks winhttp
winetricks msscript
winetricks cjkfonts
echo '* Creating start script ...'
touch cq
chmod +x ./cq
echo '#!/bin/bash' > cq
echo 'export WINEPREFIX=~/coolqprefix' >> cq
echo 'export LC_CTYPE=zh_CN.UTF-8' >> cq
echo 'wine ~/coolq/CQ?.exe' >> cq
