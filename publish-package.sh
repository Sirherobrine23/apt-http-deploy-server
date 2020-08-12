#!/bin/bash
cd "/var/www/html/"
# setup.sh
codename="DODEbt"
KEY="KEYbt"
# script
path_deb="/var/www/package"
MORE="--keepunusednewfiles"
# key
if [[ -e  pub.key ]];then
echo ""
else
gpg --armor --output pub.key --export $KEY
fi
while [ true ]; do
# reprepro
echo "Começamos: $(TZ=UTC+3 date +'%d/%m/%Y %H:%M:%S')"
reprepro $MORE -C main includedeb $codename $path_deb/main/*.deb
reprepro $MORE -C contrib includedeb $codename $path_deb/contrib/*.deb
reprepro $MORE -C non-free includedeb $codename $path_deb/non-free/*.deb
echo "Terminamos: $(TZ=UTC+3 date +'%d/%m/%Y %H:%M:%S')"
echo "

"
sleep 1h
done
