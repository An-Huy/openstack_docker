FROM huynda/base:yoga
MAINTAINER huynda.cloudops@gmail.com

RUN apt upgrade -y nova-api nova-conductor nova-novncproxy nova-scheduler; apt autoremove -y

COPY etc/nova.conf /etc/nova/nova.conf
RUN chown root:nova /etc/nova/nova.conf

#copy config script
COPY  scripts/* /home/
RUN chmod a+x /home/*

EXPOSE 8774
EXPOSE 6080

WORKDIR /home
ENTRYPOINT ["./entrypoint.sh"]