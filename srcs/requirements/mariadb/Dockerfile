FROM debian:bullseye

# Instalar MariaDB e dependências
RUN apt-get update && apt-get install -y mariadb-server && apt-get clean

# Criar diretório de dados e inicializar o banco
RUN mkdir -p /var/lib/mysql && \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Configurar bind-address para aceitar conexões externas
RUN echo "[mysqld]\nbind-address=0.0.0.0" >> /etc/mysql/my.cnf

# Expor a porta padrão
EXPOSE 3306

# Script para inicializar o banco com usuário/senha
COPY tools/init-db.sh /init-db.sh
RUN chmod +x /init-db.sh

# Iniciar o MariaDB
CMD ["/init-db.sh"]
