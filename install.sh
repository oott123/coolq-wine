#!/bin/bash -e
codePrefix=https://raw.githubusercontent.com/oott123/coolq-wine/master
binPrefix=https://localhost.com
if [ `arch` == 'x86_64' ]; then
    arch=64
else
    arch=86
fi
echo 'Preparing [1/3] Downloading files ...'
if [ ! -f  ./setup-wrapper.sh ]; then
    wget -O ./setup-wrapper.sh $codePrefix/setup-wrapper.sh
fi
if [ ! -f ./setup.sh ]; then
    wget -O ./setup.sh $codePrefix/setup.sh
fi
if [ "$DOWN_PREFIX" == 'yes' ]; then
    wget -O ./prefix-$arch.tar.gz $binPrefix/prefix-$arch.tar.gz
fi
echo 'Preparing [2/3] Updating apt database ...'
apt-get update > /dev/null
echo 'Preparing [3/3] Installing byobu ...'
apt-get install -y byobu > /dev/null
echo 'Starting ...'
byobu new-session bash ./setup-wrapper.sh