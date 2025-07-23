#!/bin/sh

if [ -f "/var/www/wordpress/wp-config.php" ]

then
  echo "✅ Wordpress já se encontra configurado."

else
  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp
  wp core download --path=/var/www/wordpress --locale=pt_BR --allow-root
  wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --path=/var/www/wordpress --skip-check --allow-root
  wp core install --path=/var/www/wordpress --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_PASS --admin_email=$WP_EMAIL --skip-email --allow-root
  wp theme install beep --path=/var/www/wordpress --activate --allow-root
  wp user create $WP_USER2 $WP_EMAIL2 --role=author --path=/var/www/wordpress --user_pass=$WP_PASS2 --allow-root

fi

/usr/sbin/php-fpm7.4 -F
