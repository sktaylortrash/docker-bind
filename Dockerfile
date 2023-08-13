FROM ubuntu:latest AS add-apt-repositories

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y curl gnupg \
 && curl -sSL https://download.webmin.com/developers-key.asc | apt-key add \
 && echo "deb http://download.webmin.com/download/newkey/repository stable contrib" >> /etc/apt/sources.list

FROM ubuntu:latest

ENV BIND_USER=bind \
    BIND_VERSION=9.18.1 \
    WEBMIN_VERSION=2.101 \
    DATA_DIR=/data

COPY --from=add-apt-repositories /etc/apt/trusted.gpg /etc/apt/trusted.gpg
COPY --from=add-apt-repositories /etc/apt/sources.list /etc/apt/sources.list
COPY entrypoint.sh /entrypoint.sh

RUN rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
 && apt-get update \
 && apt-get upgrade -y \ 
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      bind9 bind9-host dnsutils \
      webmin \
      cron \
 && rm -rf /var/lib/apt/lists/* \
 && chmod 755 /entrypoint.sh

EXPOSE 53/udp 53/tcp 10000/tcp

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/named"]
