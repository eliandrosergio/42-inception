NAME			=	inception
DOCC			=	docker-compose
COMPOSE_FILE	=	./srcs/docker-compose.yml

# Alvo padrão: construir e iniciar o projeto
all: build up

# Construir as imagens do Docker
build:
	@echo "Construindo imagens do Docker..."
	@$(DOCC) -f $(COMPOSE_FILE) build

# Iniciar os serviços em modo detached
up:
	@echo "Iniciando serviços..."
	@$(DOCC) -f $(COMPOSE_FILE) up -d

# Iniciar containers parados
start:
	@echo "Iniciando containers..."
	@$(DOCC) -f $(COMPOSE_FILE) start

# Parar e remover os serviços
down:
	@echo "Parando serviços..."
	@$(DOCC) -f $(COMPOSE_FILE) down

# Remover containers e limpar volumes
remove: down
	@echo "Removendo containers e volumes..."
	@docker volume prune -f
	@docker container prune -f

# Reconstruir e reiniciar tudo
re: remove build up

# Listar containers e imagens
list:
	@echo "Listando containers:"
	@docker ps -a
	@echo "Listando imagens:"
	@docker images -a

# Mostrar logs dos serviços
logs:
	@echo "Exibindo logs dos serviços..."
	@cd srcs && $(DOCC) logs mariadb wordpress nginx

# Alvos que não são arquivos
.PHONY: all build up start down remove re list logs
