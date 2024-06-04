FROM huynda/base:yoga
MAINTAINER huynda.cloudops@gmail.com

RUN apt upgrade -y neutron-server

COPY etc/neutron.conf /etc/neutron/neutron.conf
COPY etc/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini

#copy config script
COPY  scripts/* /home/
RUN chmod a+x /home/*

EXPOSE 9696
WORKDIR /home
ENTRYPOINT ["./entrypoint.sh"]