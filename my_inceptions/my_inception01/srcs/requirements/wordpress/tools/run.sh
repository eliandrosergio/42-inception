#!/bin/sh

mkdir -p $WP_PATH
chown -R www-data $WP_PATH

if [ -f "${WP_PATH}/wp-config.php" ]

then
	echo "WordPress existente."

else
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp
	wp core download --path=$WP_PATH --allow-root
	wp config create --dbname=$MYSQL_DB --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASS --dbhost=mariadb --path=$WP_PATH --skip-check -allow-root
	wp core install --path=$WP_PATH --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_PASS --admin_email=$WP_EMAIL --skip-email --allow-root
	wp theme install teluro --path=$WP_PATH --activate --allow-root
	wp user create $WP_USER2 $WP_EMAIL2 --role=author --path=$WP_PATH --user_pass=$WP_PASS2 --allow-root

fi 

/usr/sbin/php-fpm7.4 -F
