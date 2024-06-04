FROM ubuntu:jammy

ENV DEBIAN_FRONTEND noninteractive

RUN apt update; apt install -y software-properties-common crudini