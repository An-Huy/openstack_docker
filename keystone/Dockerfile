FROM huynda/base:yoga
LABEL maintainer="huynda.cloudops@gmail.com"

RUN apt update; apt install -y keystone apache2

COPY ./etc/keystone.conf /etc/keystone/keystone.conf

COPY ./scripts/* /home/
RUN chmod a+x /home/*

EXPOSE 5000

WORKDIR /home
ENTRYPOINT ["./entrypoint.sh"]