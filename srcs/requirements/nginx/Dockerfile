FROM debian:bullseye

# Instalar nginx e openssl
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Criar diretório para certificados SSL
RUN mkdir -p /etc/nginx/ssl

# Gerar certificado SSL autoassinado
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=BR/ST=State/L=City/O=42School/OU=Student/CN=efaustin.42.fr"

# Copiar configuração do nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Criar diretório para o site
RUN mkdir -p /var/www/html

# Definir permissões
RUN chown -R www-data:www-data /var/www/html

RUN chmod -R 755 /var/www/html

# Expor porta 443
EXPOSE 443

# Iniciar nginx
CMD ["nginx", "-g", "daemon off;"]
