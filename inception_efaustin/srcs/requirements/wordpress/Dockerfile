# WORDPRESS Dockerfile

FROM debian:bullseye-slim

RUN     apt-get update -y && \
        apt-get upgrade -y && \
        apt-get install -y php \
        php7.4-mysql \
        php7.4-cli \
        php7.4-mbstring \
        php7.4-fpm \
        php7.4-gettext \
        mariadb-client \
        wget && \
        rm -rf /etc/php/7.4/fpm/pool.d/www.conf && \
        mkdir -p /run/php

COPY    ./conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY    ./tools/run.sh /tmp/

RUN     chmod +x /tmp/run.sh

ENTRYPOINT [ "sh", "/tmp/run.sh" ]
