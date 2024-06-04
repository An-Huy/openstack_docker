#!/bin/bash

#database
DATABASE_NAME=${DATABASE_NAME:-cinder}
DATABASE_USER=${DATABASE_USER:-cinder}
DATABASE_PASS=${DATABASE_PASS}
DATABASE_HOST=${DATABASE_HOST:-$HOST_IP}

## service
DOMAIN_NAME=${DOMAIN_NAME:-Default}
PROJECT_NAME=${PROJECT_NAME:-service}

CINDER_USER=${CINDER_USER:-cinder}
CINDER_PASS=${CINDER_PASS}

REGION_NAME=${REGION_NAME:-RegionOne}

# IP and Domain
PROTOCOL=${PROTOCOL:-http}
MEMCACHED_HOST=${MEMCACHED_HOST:-$HOST_IP}

CONF_FILE=/etc/cinder/cinder.conf

echo "Congfigure cinder-api"
crudini --set $CONF_FILE DEFAULT transport_url $TRANSPORT_URL
crudini --set $CONF_FILE DEFAULT my_ip $HOST_IP

crudini --set $CONF_FILE database \
    connection mysql+pymysql://$DATABASE_USER:$DATABASE_PASS@$DATABASE_HOST/$DATABASE_NAME

crudini --set $CONF_FILE keystone_authtoken \
    www_authenticate_uri $PROTOCOL://$HOST_IP:5000/
crudini --set $CONF_FILE keystone_authtoken \
    auth_url $PROTOCOL://$HOST_IP:5000/
crudini --set $CONF_FILE keystone_authtoken \
    memcached_servers $MEMCACHED_HOST:11211
crudini --set $CONF_FILE keystone_authtoken auth_type password
crudini --set $CONF_FILE keystone_authtoken project_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE keystone_authtoken user_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE keystone_authtoken project_name $PROJECT_NAME
crudini --set $CONF_FILE keystone_authtoken username $CINDER_USER
crudini --set $CONF_FILE keystone_authtoken password $CINDER_PASS