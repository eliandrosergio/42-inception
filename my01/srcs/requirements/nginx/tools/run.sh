#!/bin/sh

mkdir -p $WP_PATH
chown -R www-data $WP_PATH

openssl req -x509 -nodes -days 365 \
-subj "/C=FR/ST=Paris/L=Paris/O=42/OU='${MYSQL_USER}'/CN='${DOMAIN_NAME}'" -newkey rsa:2048 \
-keyout $CERTS_KEY -out $CERTS_CRT

sed -i 's|DOMAIN_NAME|'${DOMAIN_NAME}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|WP_PATH|'${WP_PATH}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|PHP_HOST|'${PHP_HOST}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|PHP_PORT|'${PHP_PORT}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|CERTS_KEY|'${CERTS_KEY}'|g' /etc/nginx/sites-available/default.conf
sed -i 's|CERTS_CRT|'${CERTS_CRT}'|g' /etc/nginx/sites-available/default.conf

nginx -g "daemon off;"