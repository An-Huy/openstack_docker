#!/bin/bash

## database
DATABASE_NAME=${DATABASE_NAME:-neutron}
DATABASE_USER=${DATABASE_USER:-neutron}
DATABASE_PASS=${DATABASE_PASS}
DATABASE_HOST=${DATABASE_HOST:-$HOST_IP}

# IP and domain
PROTOCOL=${PROTOCOL:-http}

## service
DOMAIN_NAME=${DOMAIN_NAME:-Default}
PROJECT_NAME=${PROJECT_NAME:-service}
NEUTRON_USER=${NEUTRON_USER:-neutron}
NEUTRON_PASS=${NEUTRON_PASS}

REGION_NAME=${REGION_NAME:-RegionOne}

## nova
NOVA_USER=${NOVA_USER:-nova}
NOVA_PASS=${NOVA_PASS:-vccloud}

echo "Configure neutron server"
NEUTRON_CONF_FILE=/etc/neutron/neutron.conf

crudini --set $NEUTRON_CONF_FILE DEFAULT transport_url $TRANSPORT_URL

crudini --set $NEUTRON_CONF_FILE database \
    connection mysql+pymysql://$DATABASE_USER:$DATABASE_PASS@$DATABASE_HOST/$DATABASE_NAME

crudini --set $NEUTRON_CONF_FILE keystone_authtoken \
    auth_url $PROTOCOL://$HOST_IP/identity
crudini --set $NEUTRON_CONF_FILE keystone_authtoken auth_url $PROTOCOL://$HOST_IP:5000
crudini --set $NEUTRON_CONF_FILE keystone_authtoken memcached_servers $HOST_IP:11211
crudini --set $NEUTRON_CONF_FILE keystone_authtoken auth_type password
crudini --set $NEUTRON_CONF_FILE keystone_authtoken project_domain_name $DOMAIN_NAME
crudini --set $NEUTRON_CONF_FILE keystone_authtoken user_domain_name $DOMAIN_NAME
crudini --set $NEUTRON_CONF_FILE keystone_authtoken project_name $PROJECT_NAME
crudini --set $NEUTRON_CONF_FILE keystone_authtoken username $NEUTRON_USER
crudini --set $NEUTRON_CONF_FILE keystone_authtoken password $NEUTRON_PASS

crudini --set $NEUTRON_CONF_FILE nova \
    auth_url $PROTOCOL://$HOST_IP:5000
crudini --set $NEUTRON_CONF_FILE nova auth_type password
crudini --set $NEUTRON_CONF_FILE nova project_domain_name $DOMAIN_NAME
crudini --set $NEUTRON_CONF_FILE nova user_domain_name $DOMAIN_NAME
crudini --set $NEUTRON_CONF_FILE nova region_name $REGION_NAME
crudini --set $NEUTRON_CONF_FILE nova project_name $PROJECT_NAME
crudini --set $NEUTRON_CONF_FILE nova username $NOVA_USER
crudini --set $NEUTRON_CONF_FILE nova password $NOVA_PASS