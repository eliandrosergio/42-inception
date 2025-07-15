#!/bin/bash

# Iniciar o MariaDB em background para configuração
mysqld_safe &

# Aguardar o MariaDB estar pronto
echo "Aguardando MariaDB inicializar..."
until mysqladmin ping -h localhost --silent; do
    sleep 1
done

echo "MariaDB iniciado, configurando usuários..."

# Configurar usuário root
mysql -e "UPDATE mysql.user SET Host='%' WHERE User='root' AND Host='localhost';"
mysql -e "SET PASSWORD FOR 'root'@'%' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"

# Criar banco e usuário
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

echo "Configuração concluída!"

# Parar o processo em background
pkill mysqld
sleep 2

# Manter o MariaDB em foreground
exec mysqld_safe
