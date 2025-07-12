#!/bin/bash

# Aguardar o banco de dados estar pronto
echo "Aguardando banco de dados..."
while ! mysqladmin ping -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" --silent; do
    sleep 1
done

cd /var/www/html

# Criar wp-config.php se não existir
if [ ! -f wp-config.php ]; then
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST" \
        --allow-root

    # Configurar URLs do WordPress
    wp config set WP_HOME "$WP_URL" --allow-root
    wp config set WP_SITEURL "$WP_URL" --allow-root
    
    # Configurar debug como false
    wp config set WP_DEBUG false --allow-root
fi

# Instalar WordPress se não estiver instalado
if ! wp core is-installed --allow-root; then
    wp core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    # Criar usuário adicional
    wp user create \
        "$WP_USER" \
        "$WP_EMAIL" \
        --user_pass="$WP_PASSWORD" \
        --role=author \
        --allow-root
fi

# Definir permissões corretas
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Iniciar PHP-FPM
php-fpm7.4 -F
