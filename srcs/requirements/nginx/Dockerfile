FROM debian:bullseye-slim

RUN apt update -y && apt upgrade -y

RUN apt install -y nginx && apt install openssl -y 

# COPY ./conf/default /etc/nginx/sites-available/

COPY ./tools/script.sh /

CMD [ "/script.sh" ]
