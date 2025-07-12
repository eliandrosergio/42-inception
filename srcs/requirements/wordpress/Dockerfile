FROM debian:bullseye

# Instalar PHP-FPM e extensões necessárias
RUN apt-get update && \
    apt-get install -y \
        php7.4-fpm \
        php7.4-mysql \
        php7.4-curl \
        php7.4-gd \
        php7.4-mbstring \
        php7.4-xml \
        php7.4-xmlrpc \
        php7.4-soap \
        php7.4-intl \
        php7.4-zip \
        php7.4-cli \
        wget \
        curl \
        mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Criar diretório para o site
RUN mkdir -p /var/www/html

# Baixar e instalar WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    cp -r wordpress/* /var/www/html/ && \
    rm -rf wordpress latest.tar.gz

# Baixar WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/wp-cli/master/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Configurar PHP-FPM
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's/;listen.owner = www-data/listen.owner = www-data/' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's/;listen.group = www-data/listen.group = www-data/' /etc/php/7.4/fpm/pool.d/www.conf && \
    sed -i 's/;listen.mode = 0660/listen.mode = 0660/' /etc/php/7.4/fpm/pool.d/www.conf

# Copiar script de configuração
COPY tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

# Definir permissões
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expor porta 9000
EXPOSE 9000

# Executar script de configuração
CMD ["/tmp/setup.sh"]
