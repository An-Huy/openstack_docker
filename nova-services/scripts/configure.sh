#!/bin/bash

#database
API_DATABASE_NAME=${API_DATABASE_NAME:-nova_api}
API_DATABASE_USER=${API_DATABASE_USER:-nova_api}
API_DATABASE_PASS=${API_DATABASE_PASS}
API_DATABASE_HOST=${API_DATABASE_HOST:-$HOST_IP}

CELL1_DATABASE_NAME=${CELL1_DATABASE_NAME:-nova_cell1}
CELL1_DATABASE_USER=${CELL1_DATABASE_USER:-nova_cell1}
CELL1_DATABASE_PASS=${CELL1_DATABASE_PASS}
CELL1_DATABASE_HOST=${CELL1_DATABASE_HOST:-$HOST_IP}

## service
DOMAIN_NAME=${DOMAIN_NAME:-Default}
PROJECT_NAME=${PROJECT_NAME:-service}

NOVA_USER=${NOVA_USER:-nova}
NOVA_PASS=${NOVA_PASS}

PLACEMENT_USER=${PLACEMENT_USER:-placement}
PLACEMENT_PASS=${PLACEMENT_PASS}
## neutron
NEUTRON_USER=${NEUTRON_USER:-neutron}
NEUTRON_PASS=${NEUTRON_PASS}
METADATA_SECRET=${METADATA_SECRET}

HOSTNAME=${NODE_NAME:-$HOSTNAME}
REGION_NAME=${REGION_NAME:-RegionOne}

# IP and Domain
PROTOCOL=${PROTOCOL:-http}
MEMCACHED_HOST=${MEMCACHED_HOST:-$HOST_IP}

RAM_FILTER=${RAM_FILTER}
CPU_FILTER=${CPU_FILTER}

CONF_FILE=/etc/nova/nova.conf

echo "Congfigure nova-api"
crudini --set $CONF_FILE DEFAULT transport_url $TRANSPORT_URL
crudini --set $CONF_FILE DEFAULT my_ip $HOST_IP
crudini --set $CONF_FILE DEFAULT host $HOSTNAME

crudini --set $CONF_FILE api_database \
    connection mysql+pymysql://$API_DATABASE_USER:$API_DATABASE_PASS@$API_DATABASE_HOST/$API_DATABASE_NAME

crudini --set $CONF_FILE database \
    connection mysql+pymysql://$CELL1_DATABASE_USER:$CELL1_DATABASE_PASS@$CELL1_DATABASE_HOST/$CELL1_DATABASE_NAME

crudini --set $CONF_FILE cinder os_region_name $REGION_NAME

crudini --set $CONF_FILE filter_scheduler ram_weight_multiplier $RAM_FILTER
crudini --set $CONF_FILE filter_scheduler cpu_weight_multiplier $CPU_FILTER

crudini --set $CONF_FILE glance \
    api_servers $PROTOCOL://$HOST_IP:9292

crudini --set $CONF_FILE keystone_authtoken service_token_roles $PROJECT_NAME
crudini --set $CONF_FILE keystone_authtoken service_token_roles_required True
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
crudini --set $CONF_FILE keystone_authtoken username $NOVA_USER
crudini --set $CONF_FILE keystone_authtoken password $NOVA_PASS

crudini --set $CONF_FILE neutron \
    auth_url $PROTOCOL://$HOST_IP:5000
crudini --set $CONF_FILE neutron auth_type password
crudini --set $CONF_FILE neutron project_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE neutron user_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE neutron region_name $REGION_NAME
crudini --set $CONF_FILE neutron project_name $PROJECT_NAME
crudini --set $CONF_FILE neutron username $NEUTRON_USER
crudini --set $CONF_FILE neutron password $NEUTRON_PASS

crudini --set $CONF_FILE neutron service_metadata_proxy True
crudini --set $CONF_FILE neutron metadata_proxy_shared_secret $METADATA_SECRET

crudini --set $CONF_FILE placement region_name $REGION_NAME
crudini --set $CONF_FILE placement project_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE placement project_name $PROJECT_NAME
crudini --set $CONF_FILE placement auth_type password
crudini --set $CONF_FILE placement user_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE placement \
    auth_url $PROTOCOL://$HOST_IP:5000/v3
crudini --set $CONF_FILE placement username $PLACEMENT_USER
crudini --set $CONF_FILE placement password $PLACEMENT_PASS

crudini --set $CONF_FILE service_user send_service_user_token True
crudini --set $CONF_FILE service_user \
    auth_url $PROTOCOL://$HOST_IP:5000/identity
crudini --set $CONF_FILE service_user auth_strategy keystone
crudini --set $CONF_FILE service_user auth_type password
crudini --set $CONF_FILE service_user project_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE service_user user_domain_name $DOMAIN_NAME
crudini --set $CONF_FILE service_user project_name $PROJECT_NAME
crudini --set $CONF_FILE service_user username $NOVA_USER
crudini --set $CONF_FILE service_user password $NOVA_PASS