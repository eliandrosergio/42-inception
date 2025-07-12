FROM debian:bullseye

# Instalar MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Configurar MariaDB
RUN sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf && \
    sed -i 's/#port.*/port = 3306/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Copiar script de configuração
COPY tools/setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh

# Criar diretório para dados
RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql

# Expor porta 3306
EXPOSE 3306

# Executar script de configuração
CMD ["/tmp/setup.sh"]
