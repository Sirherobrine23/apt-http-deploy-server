#!/bin/bash

### BEGIN INIT INFO
# Provides:             apt-repo-script start
# Required-Start:       $network
# Required-Stop:        
# Default-Start:        2 3 4 5
# Default-Stop:         
# Short-Description:    Seu proprio servidor apt
### END INIT INFO

NAME="BDS"
if [[ "$EUID" -ne 0 ]]; then
echo "Você não está executando o service com root ou sudo";exit 1
fi
startsh23(){
bash /var/www/html/.pub.sh &
}
case "$1" in 
    start) startsh23 ;;
esac
exit 0

