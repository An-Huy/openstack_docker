FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive

RUN apt update; apt install -y software-properties-common crudini
RUN add-apt-repository cloud-archive:yoga