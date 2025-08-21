#!/bin/sh

# Criar diretório do adminer
mkdir -p /var/www/adminer
chown -R www-data:www-data /var/www/adminer

# Baixar adminer se não existir
if [ ! -f "/var/www/adminer/index.php" ]; then
    echo "📥 Baixando Adminer..."
    wget "http://www.adminer.org/latest.php" -O /var/www/adminer/index.php
    chown www-data:www-data /var/www/adminer/index.php
    echo "✅ Adminer baixado com sucesso."
else
    echo "✅ Adminer já existe."
fi

# Iniciar PHP-FPM
/usr/sbin/php-fpm8.2 -F
