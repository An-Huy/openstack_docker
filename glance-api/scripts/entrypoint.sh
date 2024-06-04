#! /bin/bash
./configure.sh
if [ "$PROCESS" == "api" ];then
    echo "Populate the Image service database"
    glance-manage db_sync
fi
echo "Starting glance-"$PROCESS
    glance-$PROCESS --config-file=/etc/glance/glance-$PROCESS.conf --log-file=/var/log/glance/glance-$PROCESS.log