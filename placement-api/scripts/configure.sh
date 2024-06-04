#!/bin/bash

#database
DATABASE_NAME=${DATABASE_NAME:-placement}
DATABASE_USER=${DATABASE_USER:-placement}
DATABASE_PASS=${DATABASE_PASS}
DATABASE_HOST=${DATABASE_HOST:-$HOST_IP}

## service
DOMAIN_NAME=${DOMAIN_NAME:-Default}
PROJECT_NAME=${PROJECT_NAME:-service}
PLACEMENT_USER=${PLACEMENT_USER:-placement}
PLACEMENT_PASS=${PLACEMENT_PASS}

#IP and Domain
PROTOCOL=${PROTOCOL:-http}
MEMCACHED_HOST=${MEMCACHED_HOST:-$HOST_IP}

CONF_FILE=/etc/placement/placement.conf

echo "Congfigure placement-api"
crudini --set $CONF_FILE placement_database \
    connection mysql+pymysql://$DATABASE_USER:$DATABASE_PASS@$DATABASE_HOST/$DATABASE_NAME

crudini --set $CONF_FILE keystone_authtoken \
    auth_url $PROTOCOL://$HOST_IP:5000/v3
crudini --set $CONF_FILE keystone_authtoken \
    memcached_servers $MEMCACHED_HOST:11211

crudini --set $CONF_FILE keystone_authtoken auth_type password
crudini --set $CONF_FILE keystone_authtoken project_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE keystone_authtoken user_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE keystone_authtoken project_name $PROJECT_NAME
crudini --set $CONF_FILE keystone_authtoken username $PLACEMENT_USER
crudini --set $CONF_FILE keystone_authtoken password $PLACEMENT_PASS