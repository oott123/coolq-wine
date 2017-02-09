#!/bin/bash -e
codePrefix=https://localhost.com
binPrefix=https://localhost.com
echo 'Preparing [1/3] Downloading files ...'
if [ ! -f  ./setup-wrapper.sh ]; then
    wget -O ./setup-wrapper.sh $codePrefix/setup-wrapper.sh
fi
if [ ! -f ./setup.sh ]; then
    wget -O ./setup.sh $codePrefix/setup.sh
fi
if [ "$DOWN_PREFIX" == 'yes' ]; then
    wget -O ./prefix.tar.gz $binPrefix/prefix.tar.gz
fi
if [ "$DOWN_WINE" == 'yes' ]; then
    wget -O ./wine.tar.gz $binPrefix/wine.tar.gz
fi
echo 'Preparing [1/3] Updating apt database ...'
apt-get update > /dev/null
echo 'Preparing [2/3] Installing byobu ...'
apt-get install -y byobu > /dev/null
echo 'Preparing [3/3] Execute script using byobu ...'
byobu new-session bash -e ./setup-wrapper.sh