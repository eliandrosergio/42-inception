#!/bin/bash

# Verificar se o MariaDB já foi inicializado
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Inicializando base de dados MariaDB..."
    
    # Inicializar a base de dados
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    
    # Ler as passwords dos secrets
    MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
    MYSQL_PASSWORD=$(cat /run/secrets/db_password)

    # Iniciar o MariaDB temporariamente
    mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 <<EOF
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

    echo "Base de dados MariaDB inicializada com sucesso!"
else
    echo "Base de dados MariaDB já existe, a prosseguir..."
fi

# Executar o comando passado como parâmetro
exec "$@"

