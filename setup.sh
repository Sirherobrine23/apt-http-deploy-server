#!/bin/bash
echo "Atualizando repositorio e instalando alguns pacotes"
apt update -qq 
apt list --upgradable -qq &>> setup.log
apt-get install -y -qq reprepro dpkg-dev apache2 rng-tools &>> setup.log
rm -r /var/www/html/index.html &>> setup.log
echo "você ja alterou o conf/distribuitions de enter se sim se não CTRL + C"
read NULL

gpg --gen-key
echo " "
echo " "
gpg --list-keys
echo "por favor copie a chave publica gerada e cole aqui no Terminal"
read KEY
echo "A key informada foi: $KEY"
echo "de enter se estiver certa, se não CRTL + C"
read NULL

echo "default-key $KEY" >> $HOME/.gnupg/gpg.conf
echo "verificando sua key "
gpg --list-keys $KEY > setup.log

if [ $? -eq 2 ];then
echo "key errada ou não existe"
exit 127
fi

mkdir -p /var/www/html &>> setup.log
mkdir -p /var/www/package &>> setup.log
mkdir -p /var/www/package/main &>> setup.log
wget https://github.com/Silvenga/examples/raw/master/example-helloworld_1.0.0.0_amd64.deb -q -O /var/www/package/main/example-helloworld_1.0.0.0_amd64.deb &>> setup.log
mkdir -p /var/www/package/contrib &>> setup.log
mkdir -p /var/www/package/non-free &>> setup.log
cp -r conf /var/www/html/conf &>> setup.log


CODE="$(cat conf/distributions | grep 'Codename:' | sed 's|Codename: ||g' | sed 's|Codename:||g')"

cp -rf publish-package.sh /var/www/Publica.sh
sed "s|KEYbt|$KEY|g" -i /var/www/Publica.sh
sed "s|DODEbt|$CODE|g" -i /var/www/Publica.sh
chmod a+x /var/www/Publica.sh



cp -rf README.html /var/www/html/README.html 
read -rp "Seu ip publico ou seu dominio!  " -e -i "$(wget -qO- http://ipecho.net/plain)" DOMINIO
sed -i "s|SEUSITE|$DOMINIO|g" /var/www/html/README.html

cp -rf apache.conf /etc/apache2/sites-available/000-default.conf 
rm /etc/apache2/sites-available/default-ssl.conf &>> setup.log
service apache2 restart

cp init.d-script.sh -f /etc/init.d/apt-local
chmod a+x /etc/init.d/apt-local
update-rc.d apt-local defaults  &>> setup.log
update-rc.d apt-local enable &>> setup.log

echo "Pronto"