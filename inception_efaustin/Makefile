# My var(s)
NAME			=	inception
EC				=	echo
RM				=	sudo rm -rf
MK				=	sudo mkdir -p

DCK				=	docker
DCPS			=	docker-compose
DCPS_CMD		=	$(DCPS) -f ./srcs/docker-compose.yml

DT_DIR			=	/home/elian/data
DB_DIR			=	$(DT_DIR)/mariadb
WP_DIR			=	$(DT_DIR)/wordpress
ADMINER_DIR		=	$(DT_DIR)/adminer


# Regra para construir e iniciar o projeto
all: mkfolder build up

# Regras criar os diretórios
mkfolder:
	@$(EC) "\nPreparando os diretórios dos volumes..."
	@$(MK) $(DT_DIR)
	@$(MK) $(DB_DIR)
	@$(MK) $(WP_DIR)
	@$(MK) $(ADMINER_DIR)
	@$(EC) "Diretórios dos volumes prontas."

# Regras remover os diretórios
rmfolder:
	@$(EC) "\nRemovendo os diretórios dos volumes..."
	@$(RM) $(ADMINER_DIR)
	@$(RM) $(WP_DIR)
	@$(RM) $(DB_DIR)
	@$(RM) $(DT_DIR)
	@$(EC) "Diretórios dos volumes removidas."

# Regra para construir as imagens do Docker
build:
	@$(EC) "\nConstruindo imagens do Docker..."
	@$(DCPS_CMD) build

# Regra para iniciar os serviços em modo detached
up:
	@$(EC) "\nIniciando serviços..."
	@$(DCPS_CMD) up -d

# Regra para parar e remover os serviços
down:
	@$(EC) "\nParando serviços..."
	@$(DCPS_CMD) down

# Regra para remover containers e limpar volumes
remove: down
	@$(EC) "\nRemovendo containers e volumes..."
	@$(DCK) volume prune -f
	@$(DCK) container prune -f

# Regra para parar containers parados
stop:
	@$(EC) "\nParando containers..."
	@$(DCPS_CMD) stop

# Regra para iniciar containers parados
start:
	@$(EC) "\nIniciando containers..."
	@$(DCPS_CMD) start

# Regra para parar e voltar a iniciar os containers
restart: stop start

# Regra para parar os servicoes e limpa-los
clean: down remove

# Regra para parar e limpar tudo
fclean: clean rmfolder

# Regra para reconstruir e reiniciar tudo
re: remove build up

# Regra para listar containers e imagens
list:
	@$(EC) "\nListando containers:"
	@$(DCK) ps -a
	@$(EC) "\nListando imagens:"
	@$(DCK) images -a

# Regra para mostrar logs dos serviços
logs:
	@$(EC) "\nExibindo logs dos serviços..."
	@cd srcs && $(DCPS) logs mariadb wordpress nginx adminer website

# Alvos que não são arquivos
.PHONY: all mkfolder rmfolder build up down remove stop start restart clean fclean re list logs
