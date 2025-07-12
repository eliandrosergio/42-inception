#!/bin/bash

# Inicializar banco de dados se não existir
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Inicializando banco de dados..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Iniciar MariaDB temporariamente
mysqld_safe --datadir=/var/lib/mysql &
mysql_pid=$!

# Aguardar MariaDB estar pronto
echo "Aguardando MariaDB iniciar..."
while ! mysqladmin ping --silent; do
    sleep 1
done

# Configurar usuário root
mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');"
mysql -e "DELETE FROM mysql.user WHERE User='';"
mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"

# Criar banco de dados e usuário
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Parar MariaDB temporário
kill $mysql_pid
wait $mysql_pid

# Iniciar MariaDB em modo normal
exec mysqld --user=mysql --datadir=/var/lib/mysql
