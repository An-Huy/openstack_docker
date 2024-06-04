FROM huynda/base:yoga
MAINTAINER huynda.cloudops@gmail.com

RUN apt upgrade -y cinder-api cinder-scheduler apache2; apt autoremove -y

COPY etc/cinder.conf /etc/cinder/cinder.conf
RUN chown root:cinder /etc/cinder/cinder.conf

#copy config script
COPY  scripts/* /home/
RUN chmod a+x /home/*

EXPOSE 8776
WORKDIR /home
ENTRYPOINT ["./entrypoint.sh"]