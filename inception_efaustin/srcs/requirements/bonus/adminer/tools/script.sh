#!bin/bash

mkdir -p /var/www
mkdir -p /var/www/adminer

if [ -d "/var/www/adminer/adminer.php" ]
then
  echo "✅ adminer.php existente."
else
  wget "http://www.adminer.org/latest.php" -O /var/www/adminer/adminer.php
fi

chown -R www-data:www-data /var/www/adminer/adminer.php 
chmod 755 /var/www/adminer/adminer.php

cd /var/www/adminer
cp adminer.php index.php

php -S 0.0.0.0:80
