#!/bin/bash

# Script para conectar ao MariaDB

echo "=== MySQL/MariaDB Client Connection Script ==="
echo ""

# Definir variáveis de conexão
DB_HOST="mariadb"
DB_PORT="3306"
DB_NAME="wordpress_db"
DB_USER="wp_user"

echo "Conectando ao servidor MariaDB..."
echo "Host: $DB_HOST"
echo "Port: $DB_PORT"
echo "Database: $DB_NAME"
echo "User: $DB_USER"
echo ""

# Conectar ao MariaDB
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p "$DB_NAME"

