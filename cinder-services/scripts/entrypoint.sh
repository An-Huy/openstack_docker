#!/bin/bash
./configure.sh

if [ "$PROCESS" == "api" ];then
echo "Populate the Block Storage database"
    cinder-manage db sync
echo "Configure apache"
    echo "ServerName " $HOST_IP >> /etc/apache2/apache2.conf
echo "[i] Starting daemon..."
# run apache httpd daemon
    rm -rf /var/run/apache2/*
    exec /usr/sbin/apachectl -DFOREGROUND;
else
    echo "Starting cinder-$PROCESS"
    cinder-$PROCESS --config-file /etc/cinder/cinder.conf --log-file /var/log/cinder/cinder-$PROCESS.log
fi