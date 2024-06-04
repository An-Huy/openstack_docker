echo "Fernet key setup"
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

ADMIN_PASSWORD=${ADMIN_PASSWORD}
CONTROLLER=${HOST_IP}
REGION_NAME=${REGION_NAME:-RegionOne}

CONTROLLER=${HOST_IP}
keystone-manage bootstrap --bootstrap-password $ADMIN_PASSWORD \
  	--bootstrap-admin-url http://$CONTROLLER:5000/v3/ \
  	--bootstrap-internal-url http://$CONTROLLER:5000/v3/ \
  	--bootstrap-public-url http://$CONTROLLER:5000/v3/ \
  	--bootstrap-region-id $REGION_NAME