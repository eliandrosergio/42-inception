#!/bin/sh

mkdir -p /var/www/wordpress
chown -R www-data /var/www/wordpress

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/nginx/ssl/nginx-selfsigned.key \
-out /etc/nginx/ssl/nginx-selfsigned.crt \
-subj "/C=FR/ST=Paris/L=Paris/O=42/OU='${DB_USER}'/CN='${DOMAIN_NAME}'" \
-addext "subjectAltName = DNS:'${DOMAIN_NAME}', DNS:www.'${DOMAIN_NAME}'"

sed -i 's|DOMAIN_NAME|'${DOMAIN_NAME}'|g' /etc/nginx/sites-available/default.conf

nginx -g "daemon off;"
