# vi: set ft=dockerfile :

FROM centos:7
MAINTAINER Kazuhisa Hara <khara@sios.com>

RUN yum install -y --setopt=tsflags=nodocs \
        epel-release \
        bash bash-completion \
        screen \
        vim && \
    yum install -y --setopt=tsflags=nodocs \
        golang \
        jq \
        supervisor \
        vim-go && \
    rm -rf /var/cache/yum

WORKDIR /root

RUN echo "shell /usr/bin/bash" > /root/.screenrc

ADD server.go /root/server.go
RUN go build server.go
ADD supervisord.conf /etc/supervisord.conf

EXPOSE 8080
CMD /usr/bin/supervisord -c /etc/supervisord.conf
