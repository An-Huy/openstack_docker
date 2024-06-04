FROM huynda/base:yoga
MAINTAINER huynda.cloudops@gmail.com

RUN apt install -y \
    neutron-plugin-ml2 \
    neutron-openvswitch-agent \
    neutron-dhcp-agent \
    neutron-metadata-agent; apt autoremove -y