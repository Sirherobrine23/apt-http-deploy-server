#!/bin/bash
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
gpg --armor --output var/www/html/pub.key --export $KEY
fi
while [ true ]; do
# reprepro
reprepro $MORE -C main includedeb $codename $path_deb/main/*.deb
reprepro $MORE -C contrib includedeb $codename $path_deb/contrib/*.deb
sleep 1h
done
