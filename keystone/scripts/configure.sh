#!/bin/bash

DATABASE_NAME=${DATABASE_NAME:-keystone}
DATABASE_USER=${DATABASE_USER:-keystone}
DATABASE_PASS=${DATABASE_PASS}
DATABASE_HOST=${DATABASE_HOST:-$HOST_IP}

TOKEN_EXPIRE=${TOKEN_EXPIRE}

CONF_FILE=/etc/keystone/keystone.conf

echo "Congfigure keystone"
crudini --set $CONF_FILE cache backend_argument url:$HOST_IP:11211
crudini --set $CONF_FILE database \
	connection  mysql+pymysql://$DATABASE_USER:$DATABASE_PASS@$DATABASE_HOST/$DATABASE_NAME
crudini --set $CONF_FILE token expiration $TOKEN_EXPIRE