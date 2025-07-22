#!/bin/bash

sed -i 's|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|g' /etc/mysql/mariadb.conf.d/50-server.cnf

sed -i 's|#localhost which is more compatible and is not less secure.|port                    = 3306|g' /etc/mysql/mariadb.conf.d/50-server.cnf

service mysql start

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DB ;" > db1.sql
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON $MYSQL_DB.* TO '$MYSQL_USER'@'%' ;" >> db1.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_RPASS' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mysql < db1.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
