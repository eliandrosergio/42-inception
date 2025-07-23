#!bin/bash

mkdir -p /var/www
mkdir -p /var/www/adminer

wget "http://www.adminer.org/latest.php" -O /var/www/adminer/adminer.php

chown -R www-data:www-data /var/www/adminer/adminer.php 
chmod 755 /var/www/adminer/adminer.php

cd /var/www/adminer

rm -rf index.html
php -S 0.0.0.0:80
