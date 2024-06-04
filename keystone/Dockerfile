FROM huynda/base:yoga
MAINTAINER huynda.cloudops@gmail.com

RUN apt upgrade -y keystone apache2

COPY ./etc/keystone.conf /etc/keystone/keystone.conf
RUN chown keystone:keystone /etc/keystone/keystone.conf

COPY ./scripts/* /home/
RUN chmod a+x /home/*

EXPOSE 5000

WORKDIR /home
ENTRYPOINT ["./entrypoint.sh"]