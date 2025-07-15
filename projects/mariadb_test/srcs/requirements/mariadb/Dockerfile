FROM debian:11

# Instalar MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Criar diretório para scripts
RUN mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /var/lib/mysql

# Copiar script de inicialização
COPY tools/mariadb_init.sh /usr/local/bin/mariadb_init.sh
RUN chmod +x /usr/local/bin/mariadb_init.sh

# Copiar configuração personalizada
COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf

# Criar diretório para sockets
RUN mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld

# Expor porta
EXPOSE 3306

# Executar como usuário mysql
USER mysql

# Comando para iniciar o MariaDB
CMD ["/usr/local/bin/mariadb_init.sh && mysqld && tail -f /dev/null"]

