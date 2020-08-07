#!/bin/bash
apt update && apt install -y reprepro dpkg-dev
gpg --gen-keys
gpg --list-keys
echo "por favor copie a chave publica gerada e cole aqui no Terminal"
read KEY
echo "A key informada foi: $KEY"
sleep 5
echo "de enter se estiver certa, se não CRTL + C"
read NULL

... continua
