#!bin/bash

wget "http://www.adminer.org/latest.php" -O /var/www/wordpress/adminer.php

chown -R www-data:www-data /var/www/wordpress/adminer.php 
chmod 755 /var/www/wordpress/adminer.php

cd /var/www/wordpress

rm -rf index.html
php -S 0.0.0.0:80
