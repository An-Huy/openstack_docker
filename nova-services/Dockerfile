FROM huynda/base:yoga
LABEL maintainer="huynda.cloudops@gmail.com"

RUN apt update; apt install -y nova-api nova-conductor nova-novncproxy nova-scheduler

COPY etc/nova.conf /etc/nova/nova.conf

#copy config script
COPY  scripts/* /home/
RUN chmod a+x /home/*

EXPOSE 8774
EXPOSE 6080

WORKDIR /home
ENTRYPOINT ["./entrypoint.sh"]