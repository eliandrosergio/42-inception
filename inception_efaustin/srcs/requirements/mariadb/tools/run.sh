#!/bin/sh

# Lendo as senhas dos secrets
DB_PASS=$(cat /run/secrets/db_password)
DB_RTPASS=$(cat /run/secrets/db_root_password)

# Substituindo as variáveis no arquivo SQL
sed -i 's|DB_NAME|'${DB_NAME}'|g' /tmp/init.sql
sed -i 's|DB_USER|'${DB_USER}'|g' /tmp/init.sql
sed -i 's|DB_PASS|'${DB_PASS}'|g' /tmp/init.sql
sed -i 's|DB_RTPASS|'${DB_RTPASS}'|g' /tmp/init.sql

if [ -d "/var/lib/mysql/$DB_NAME" ]
then
  echo "✅ Database existente."
  mysqld_safe
else
  mysql_install_db
  mysqld --init-file="/tmp/init.sql"
fi

exec "$@"
