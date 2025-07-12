FROM debian:bullseye-slim

RUN apt-get -y update && apt-get -y upgrade && apt update -y && apt upgrade -y

RUN apt install php-fpm php-mysql -y

RUN apt install curl -y

COPY ./tools/wp-config.php /

COPY ./tools/script.sh /

CMD [ "/script.sh" ]
