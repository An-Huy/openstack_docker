FROM huynda/base:yoga
LABEL maintainer="huynda.cloudops@gmail.com"

RUN apt update; apt install -y glance

COPY etc/glance-api.conf /etc/glance/glance-api.conf

#copy config script
COPY  scripts/* /home/
RUN chmod a+x /home/*

EXPOSE 9292
VOLUME /var/lib/glance/images/

WORKDIR /home/
ENTRYPOINT ["./entrypoint.sh"]