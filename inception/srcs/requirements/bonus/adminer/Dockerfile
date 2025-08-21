FROM debian:bookworm-slim

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    php8.2 \
    php8.2-mysql \
    php8.2-fpm \
    wget && \
    rm -rf /etc/php/8.2/fpm/pool.d/www.conf && \
    mkdir -p /run/php && \
    mkdir -p /var/www/adminer

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/
COPY ./tools/run.sh /tmp/

RUN chmod +x /tmp/run.sh

EXPOSE 9001

ENTRYPOINT ["sh", "/tmp/run.sh"]
