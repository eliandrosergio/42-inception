FROM	debian:bullseye-slim

# Instalar dependências necessárias
RUN		apt-get update && \
		apt-get install -y \
		fail2ban \
		iptables \
		rsyslog && \
		rm -rf /var/lib/apt/lists/*

# Criar diretórios necessários
RUN		mkdir -p /var/log/fail2ban && \
		mkdir -p /etc/fail2ban/jail.d

# Copiar configurações customizadas
COPY	./tools/jail.local /etc/fail2ban/jail.local
COPY	./tools/nginx-wordpress.conf /etc/fail2ban/filter.d/
COPY	./tools/run.sh /

# Dar permissão de execução
RUN		chmod +x /run.sh

# Expor porta para monitoramento (opcional)
EXPOSE	8080

CMD	["/run.sh"]
