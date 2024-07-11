FROM huynda/base:yoga
LABEL maintainer="huynda.cloudops@gmail.com"

RUN apt update; apt install -y placement-api python3-pymysql

COPY etc/placement.conf /etc/placement/placement.conf

#copy config script
COPY  scripts/* /home/
RUN chmod a+x /home/*

EXPOSE 8778
WORKDIR /home/

ENTRYPOINT ["./entrypoint.sh"]