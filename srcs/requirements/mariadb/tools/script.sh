#!/bin/bash
#efaustin

service mysql start 

echo "CREATE DATABASE IF NOT EXISTS $mariadb_name ;" > db1.sql

echo "CREATE USER IF NOT EXISTS '$mariadb_user'@'%' IDENTIFIED BY '$mariadb_pwd' ;" >> db1.sql

echo "GRANT ALL PRIVILEGES ON $mariadb_name.* TO '$mariadb_user'@'%' ;" >> db1.sql

echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> db1.sql

echo "FLUSH PRIVILEGES;" >> db1.sql

mysql < db1.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
