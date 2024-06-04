#!/bin/bash

#database
DATABASE_NAME=${DATABASE_NAME:-glance}
DATABASE_USER=${DATABASE_USER:-glance}
DATABASE_PASS=${DATABASE_PASS}
DATABASE_HOST=${DATABASE_HOST:-$HOST_IP}

## service
DOMAIN_NAME=${DOMAIN_NAME:-Default}
PROJECT_NAME=${PROJECT_NAME:-service}
GLANCE_USER=${GLANCE_USER:-glance}
GLANCE_PASS=${GLANCE_PASS}

# IP and Domain
PROTOCOL=${PROTOCOL:-http}
MEMCACHED_HOST=${MEMCACHED_HOST:-$HOST_IP}

#Glance stores
GLANCE_STORE=${GLANCE_STORE:-file,http}
DEFAULT_STORE=${DEFAULT_STORE:-file}

CONF_FILE=/etc/glance/glance-api.conf

echo "Congfigure glance-api"
crudini --set $CONF_FILE DEFAULT transport_url $TRANSPORT_URL

crudini --set $CONF_FILE database \
    connection mysql+pymysql://$DATABASE_USER:$DATABASE_PASS@$DATABASE_HOST/$DATABASE_NAME

crudini --set $CONF_FILE keystone_authtoken \
    www_authenticate_uri $PROTOCOL://$HOST_IP:5000
crudini --set $CONF_FILE keystone_authtoken \
    auth_url $PROTOCOL://$HOST_IP:5000
crudini --set $CONF_FILE keystone_authtoken \
    memcached_servers $MEMCACHED_HOST:11211

crudini --set $CONF_FILE keystone_authtoken auth_type password
crudini --set $CONF_FILE keystone_authtoken project_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE keystone_authtoken user_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE keystone_authtoken project_name $PROJECT_NAME
crudini --set $CONF_FILE keystone_authtoken username $GLANCE_USER
crudini --set $CONF_FILE keystone_authtoken password $GLANCE_PASS

crudini --set $CONF_FILE glance_store stores $GLANCE_STORE
crudini --set $CONF_FILE glance_store default_store $DEFAULT_STORE