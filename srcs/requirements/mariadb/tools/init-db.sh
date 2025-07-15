#!/bin/bash
# Iniciar o MariaDB em background para configuração
mysqld_safe &

# Aguardar o MariaDB estar pronto
sleep 5

# Configurar usuário root e banco
mysql -e "CREATE DATABASE IF NOT EXISTS $db_name ;"
mysql -e "CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_pass';"
mysql -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Manter o MariaDB em foreground
exec mysqld
