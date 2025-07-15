NAME = inception

# Variáveis
COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = /home/$(USER)/data

# Cores para output
GREEN = \033[0;32m
YELLOW = \033[1;33m
RED = \033[0;31m
NC = \033[0m # No Color

all: build

# Criar diretórios necessários
setup:
	@echo "$(YELLOW)Criando diretórios necessários...$(NC)"
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p secrets
	@echo "$(GREEN)Diretórios criados com sucesso!$(NC)"

# Criar arquivos de secrets se não existirem
secrets: setup
	@echo "$(YELLOW)Criando arquivos de secrets...$(NC)"
	@if [ ! -f secrets/db_root_password.txt ]; then \
		echo "root_password_123" > secrets/db_root_password.txt; \
	fi
	@if [ ! -f secrets/db_password.txt ]; then \
		echo "user_password_123" > secrets/db_password.txt; \
	fi
	@echo "$(GREEN)Secrets criados com sucesso!$(NC)"

# Build das imagens
build: secrets
	@echo "$(YELLOW)Construindo imagens Docker...$(NC)"
	@cd srcs && docker-compose build
	@echo "$(GREEN)Build concluído!$(NC)"

# Iniciar os serviços
up: build
	@echo "$(YELLOW)Iniciando serviços...$(NC)"
	@cd srcs && docker-compose up -d
	@echo "$(GREEN)Serviços iniciados!$(NC)"

# Parar os serviços
down:
	@echo "$(YELLOW)Parando serviços...$(NC)"
	@cd srcs && docker-compose down
	@echo "$(GREEN)Serviços parados!$(NC)"

# Reiniciar os serviços
restart: down up

# Ver logs
logs:
	@cd srcs && docker-compose logs -f

# Conectar ao cliente MySQL
connect:
	@echo "$(YELLOW)Conectando ao cliente MySQL...$(NC)"
	@docker exec -it mysql-client /bin/bash

# Conectar diretamente ao MariaDB
mysql:
	@echo "$(YELLOW)Conectando ao MariaDB...$(NC)"
	@docker exec -it mysql-client /usr/local/bin/connect.sh

# Ver status dos containers
status:
	@echo "$(YELLOW)Status dos containers:$(NC)"
	@cd srcs && docker-compose ps

# Limpeza completa
clean: down
	@echo "$(YELLOW)Limpando sistema...$(NC)"
	@cd srcs && docker-compose down -v --rmi all
	@docker system prune -f
	@echo "$(GREEN)Sistema limpo!$(NC)"

# Limpeza completa incluindo volumes
fclean: clean
	@echo "$(YELLOW)Removendo volumes e dados...$(NC)"
	@sudo rm -rf $(DATA_DIR)
	@docker volume prune -f
	@echo "$(GREEN)Limpeza completa concluída!$(NC)"

# Reconstruir tudo
re: fclean all

# Ajuda
help:
	@echo "$(GREEN)Comandos disponíveis:$(NC)"
	@echo "  make setup     - Criar diretórios necessários"
	@echo "  make secrets   - Criar arquivos de secrets"
	@echo "  make build     - Construir imagens Docker"
	@echo "  make up        - Iniciar serviços"
	@echo "  make down      - Parar serviços"
	@echo "  make restart   - Reiniciar serviços"
	@echo "  make logs      - Ver logs dos serviços"
	@echo "  make connect   - Conectar ao cliente MySQL"
	@echo "  make mysql     - Conectar diretamente ao MariaDB"
	@echo "  make status    - Ver status dos containers"
	@echo "  make clean     - Limpeza do sistema"
	@echo "  make fclean    - Limpeza completa"
	@echo "  make re        - Reconstruir tudo"

.PHONY: all setup secrets build up down restart logs connect mysql status clean fclean re help

