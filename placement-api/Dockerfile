FROM huynda/base:yoga
MAINTAINER huynda.cloudops@gmail.com

RUN apt upgrade -y placement-api python3-pymysql

COPY etc/placement.conf /etc/placement/placement.conf
RUN chown root:placement /etc/placement/placement.conf

#copy config script
COPY  scripts/* /home/
RUN chmod a+x /home/*

EXPOSE 8778
WORKDIR /home/

ENTRYPOINT ["./entrypoint.sh"]