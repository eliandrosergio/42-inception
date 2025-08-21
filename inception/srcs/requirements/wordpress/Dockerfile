FROM debian:bookworm-slim

RUN     apt-get update -y && \
        apt-get upgrade -y && \
        apt-get install -y php \
        php8.2-mysql \
        php8.2-cli \
        php8.2-mbstring \
        php8.2-fpm \
        php8.2-gettext \
        mariadb-client \
        wget && \
        rm -rf /etc/php/8.2/fpm/pool.d/www.conf && \
        mkdir -p /run/php

COPY    ./conf/www.conf /etc/php/8.2/fpm/pool.d/
COPY    ./tools/run.sh /tmp/

RUN     chmod +x /tmp/run.sh

ENTRYPOINT [ "sh", "/tmp/run.sh" ]
