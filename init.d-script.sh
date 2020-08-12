#!/bin/bash

### BEGIN INIT INFO
# Provides:             apt-repo-script start
# Required-Start:       $network
# Required-Stop:        
# Default-Start:        2 3 4 5
# Default-Stop:         
# Short-Description:    Seu proprio servidor apt
### END INIT INFO

. /lib/lsb/init-functions

DAEMON=/var/www/Publica.sh

test -x $DAEMON || exit 127

if [[ "$EUID" -ne 0 ]]; then
    echo "Você não está executando o service com root ou sudo";exit 1
fi
start_sh(){
    screen bash /var/www/Publica.sh
}
stop_sh(){
    screen -Rd you.apt -X stuff
    screen -Rd you.apt -X stuff
    screen -Rd you.apt -X stuff
    screen -Rd you.apt -X stuff
    screen -Rd you.apt -X stuff
    screen -Rd you.apt -X stuff
    screen -Rd you.apt -X stuff
    screen -X -S apt.you quit
}
restart_sh(){
    screen -Rd you.apt -X stuff
    screen -Rd you.apt -X stuff
    screen -X -S apt.you quit
    sleep 5s
    screen -dmS you.apt bash /var/www/html/.pub.sh
}
status_sh(){
    echo "Seu pid fica no: $(ls /var/run/screen/S-root/*.apt.local*)"
}
reload_sh(){
    kill $(ls /var/run/screen/S-root/ | grep 'apt.local' | sed 's|.apt.local||g')
}
case $1 in
    start) start_sh;;
    stop) stop_sh;;
    restart) restart_sh;;
    status) status_sh;;
    reload) reload_sh
esac
exit 0
