#!/bin/sh

sed -i 's|MYSQL_DB|'${MYSQL_DB}'|g' /tmp/init.sql
sed -i 's|MYSQL_USER|'${MYSQL_USER}'|g' /tmp/init.sql
sed -i 's|MYSQL_PASS|'${MYSQL_PASS}'|g' /tmp/init.sql
sed -i 's|MYSQL_RPASS|'${MYSQL_RPASS}'|g' /tmp/init.sql

mysql < /tmp/init.sql
