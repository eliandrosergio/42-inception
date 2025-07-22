#!/bin/sh

mkdir -p $WP_PATH
chown -R www-data $WP_PATH

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=AO/L=Luanda/O=42/OU=student/CN=[${DOMAIN_NAME}](http://${DOMAIN_NAME}/)"

sed -i 's|DOMAIN_NAME|'${DOMAIN_NAME}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|WP_PATH|'${WP_PATH}'|g' /etc/nginx/sites-available/default.conf

nginx -g "daemon off;"
