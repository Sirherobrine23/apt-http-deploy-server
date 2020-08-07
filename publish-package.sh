#!/bin/bash
KEY="Chave privada gerada no arquivos anterirores"
reprepro --keepunusednewfiles -C main includedeb sh23 main-package/*.deb
reprepro --keepunusednewfiles -C contrib includedeb sh23 contrib-package/*.deb

if [[ -e  $KEY.gpg.key ]];then
echo "NÃ£o precissar criar um Key Publica"
else
gpg --armor --output $KEY.gpg.key --export $KEY
fi
