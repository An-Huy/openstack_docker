#!/bin/sh
./configure.sh
echo "sync db and create fernet token"
	keystone-manage db_sync
echo "Config apache"
	echo "ServerName " $HOST_IP >> /etc/apache2/apache2.conf
echo "bootstrap keystone"
	./bootstrap.sh
echo "[i] Starting daemon..."
# run apache httpd daemon
	rm -rf /var/run/apache2/*
	exec /usr/sbin/apachectl -DFOREGROUND;