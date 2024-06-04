#!/bin/bash
./configure.sh

echo "Populate the database"
neutron-db-manage --config-file /etc/neutron/neutron.conf \
  --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head

echo "Starting neutron-server"
/usr/bin/neutron-server --config-file=/etc/neutron/neutron.conf --config-file=/etc/neutron/plugins/ml2/ml2_conf.ini --log-file /var/log/neutron/neutron-server.log