FROM debian:bookworm-slim

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs 

# Copiar arquivos de setup para diretório temporário
COPY ./tools/server.js /tmp/website-setup/
COPY ./tools/index.html /tmp/website-setup/
COPY ./tools/style.css /tmp/website-setup/
COPY ./tools/package.json /tmp/website-setup/
COPY ./tools/run.sh /tmp/

RUN chmod +x /tmp/run.sh

# Criar diretório de trabalho
RUN mkdir -p /var/www/website && \
    chown -R www-data:www-data /var/www/website

USER www-data

EXPOSE 3000

ENTRYPOINT ["sh", "/tmp/run.sh"]
