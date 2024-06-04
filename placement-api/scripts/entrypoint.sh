#! /bin/bash
./configure.sh
echo "Populate the placement database"
    placement-manage db sync
echo "Configure apache"
    echo "ServerName " $HOST_IP >> /etc/apache2/apache2.conf
echo "[i] Starting daemon..."
# run apache httpd daemon
    rm -rf /var/run/apache2/*
    exec /usr/sbin/apachectl -DFOREGROUND;