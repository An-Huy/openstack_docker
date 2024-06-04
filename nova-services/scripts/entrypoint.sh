#!/bin/bash
###default variable

CELL0_DATABASE_USER=${CELL0_DATABASE_USER:-nova_cell0}
CELL0_DATABASE_PASS=${CELL0_DATABASE_PASS}
CELL0_DATABASE_HOST=${CELL0_DATABASE_HOST:-$HOST_IP}
CELL0_DATABASE_NAME=${CELL0_DATABASE_NAME:-nova_cell0}
./configure.sh

if [ "$PROCESS" == "api" ];then
echo "Populate the nova-api database"
    nova-manage api_db sync
  
echo "Register the cell0 database"
    nova-manage cell_v2 map_cell0 --database_connection \
	    mysql+pymysql://$CELL0_DATABASE_USER:$CELL0_DATABASE_PASS@$CELL0_DATABASE_HOST/$CELL0_DATABASE_NAME
  
echo "Create the cell1 cell"
    nova-manage cell_v2 create_cell --name=cell1 --verbose
  
echo "Populate the nova database"
    nova-manage db sync

fi
echo "Starting nova-$PROCESS"
nova-$PROCESS --log-file=/var/log/nova/nova-$PROCESS.log --config-file=/etc/nova/nova.conf