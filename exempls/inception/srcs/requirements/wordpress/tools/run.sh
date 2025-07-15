#!/bin/sh

sed -i 's|PHP_PORT|'${PHP_PORT}'|g' /etc/php/7.4/fpm/pool.d/www.conf

if [ -f "/var/www/wordpress/wp-config.php" ]

then
  echo "Wordpress already confiured."

else
  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp
  wp core download --path=$WP_PATH --allow-root
  wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --path=$WP_PATH --skip-check --allow-root
  wp core install --path=$WP_PATH --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_PASSWORD --admin_email=$WP_EMAIL --skip-email --allow-root
  wp theme install teluro --path=$WP_PATH --activate --allow-root
  wp user create leon leon@le.on --role=author --path=$WP_PATH --user_pass=leon --allow-root

fi

/usr/sbin/php-fpm7.4 -F
