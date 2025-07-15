FROM debian:11

# Instalar cliente MySQL e ferramentas úteis
RUN apt-get update && apt-get install -y \
    mariadb-client \
    vim \
    nano \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copiar script de conexão
COPY tools/connect.sh /usr/local/bin/connect.sh
RUN chmod +x /usr/local/bin/connect.sh

# Criar um usuário não-root
RUN useradd -m -s /bin/bash mysql_user

# Criar diretório para scripts SQL
RUN mkdir -p /home/mysql_user/sql_scripts
COPY tools/sample_queries.sql /home/mysql_user/sql_scripts/
RUN chown -R mysql_user:mysql_user /home/mysql_user

# Mudar para o usuário não-root
USER mysql_user
WORKDIR /home/mysql_user

# Manter o container em execução
CMD ["tail", "-f", "/dev/null"]

