#!/bin/bash
echo "Atualizando repositorio e instalando alguns pacotes"
apt update -qq && apt list -qq --upgradable && apt -qq install -y reprepro dpkg-dev apache2 rng-tools

echo "você ja alterou o conf/distribuitions de enter se sim se não CTRL + C"
read NULL

gpg --gen-key
gpg --list-keys
echo "por favor copie a chave publica gerada e cole aqui no Terminal"
read KEY
echo "A key informada foi: $KEY"
sleep 5
echo "de enter se estiver certa, se não CRTL + C"
read NULL

echo "default-key $KEY" >> $HOME/.gnupg/gpg.conf

#echo '#- bySh23' >> /etc/sudoers
#echo "$(whoami) ALL=(ALL) NOPASSWORD: ALL" >> /etc/sudoers
#echo '#- bySh23 -' >> /etc/sudoers

mkdir -p /var/www/html
mkdir -p /var/www/package
mkdir -p /var/www/package/main
wget https://github.com/Silvenga/examples/raw/master/example-helloworld_1.0.0.0_amd64.deb -q -O /var/www/package/main/example-helloworld_1.0.0.0_amd64.deb
wget https://github.com/Silvenga/examples/raw/master/example-helloworld_1.0.0.0_i386.deb -q  -O  /var/www/package/main/example-helloworld_1.0.0.0_i386.deb
mkdir -p /var/www/package/contrib
cp -r conf /var/www/html/conf


CODE="$(cat conf/distributions | grep 'Codename:' | sed 's|Codename: ||g' | sed 's|Codename:||g')"

cp -rf publish-package.sh /tmp/.pub.sh
sed 's|KEYbt|$KEY|g' -i /tmp/.pub.sh
sed 's|DODEbt|$CODE|g' -i /tmp/.pub.sh
cp -rf /tmp/.pub.sh /var/www/html

cp init.d-script.sh -f /etc/init.d/apt-local
chmod a+x /etc/init.d/apt-local
update-rc.d apt-local defaults
update-rc.d apt-local enable

echo "Pronto"