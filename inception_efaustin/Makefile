-include srcs/.env

# My var(s)
NAME			=	inception
EC				=	echo
SU				=	sudo
CH				=	$(SU) chmod
RM				=	$(SU) rm -rf
MK				=	$(SU) mkdir -p

DCK				=	docker
DCPS			=	docker-compose
DCPS_CMD		=	$(DCPS) -f ./srcs/docker-compose.yml

DT_DIR			=	/home/elian/data
DB_DIR			=	$(DT_DIR)/mariadb
WP_DIR			=	$(DT_DIR)/wordpress
ADMINER_DIR		=	$(DT_DIR)/adminer
SECRETS_DIR		=	./secrets


# Regra para construir e iniciar o projeto
all: mkfolder mksecrets build up

# Regras criar os diretórios
mkfolder:
	@$(EC) "\n📁 Preparando os diretórios dos volumes..."
	@$(MK) $(DT_DIR)
	@$(MK) $(DB_DIR)
	@$(MK) $(WP_DIR)
	@$(MK) $(ADMINER_DIR)
	@$(CH) 777 $(DT_DIR)
	@$(CH) 777 $(DB_DIR)
	@$(CH) 777 $(WP_DIR)
	@$(CH) 777 $(ADMINER_DIR)
	@$(EC) "✅ Diretórios dos volumes prontos."

# Regras remover os diretórios
rmfolder:
	@$(EC) "\n🧹 Removendo os diretórios dos volumes..."
	@$(RM) $(ADMINER_DIR)
	@$(RM) $(WP_DIR)
	@$(RM) $(DB_DIR)
	@$(RM) $(DT_DIR)
	@$(EC) "✅ Diretórios dos volumes removidos."

# Regra para criar arquivos de secrets
mksecrets:
	@$(EC) "\n🔐 Criando arquivos de secrets..."
	@$(MK) $(SECRETS_DIR)
	@$(CH) 777 $(SECRETS_DIR)
	@$(EC) "$(DB_PASS)" > $(SECRETS_DIR)/db_password.txt
	@$(EC) "$(DB_RTPASS)" > $(SECRETS_DIR)/db_root_password.txt
	@$(EC) "$(WP_PASS)" > $(SECRETS_DIR)/wp_admin_password.txt
	@$(EC) "$(WP_PASS2)" > $(SECRETS_DIR)/wp_user_password.txt
	@$(CH) 600 $(SECRETS_DIR)/*.txt
	@$(EC) "✅ Arquivos de secrets criados com permissões seguras."

# Regra para remover secrets
rmsecrets:
	@$(EC) "\n🧨 Removendo arquivos de secrets..."
	@$(RM) $(SECRETS_DIR)
	@$(EC) "✅ Arquivos de secrets removidos."

# Regra para construir as imagens do Docker
build:
	@$(EC) "\n🔨 Construindo imagens do Docker..."
	@$(DCPS_CMD) build

# Regra para iniciar os serviços em modo detached
up:
	@$(EC) "\n🚀 Iniciando serviços..."
	@$(DCPS_CMD) up -d

# Regra para parar e remover os serviços
down:
	@$(EC) "\n🛑 Parando serviços..."
	@$(DCPS_CMD) down

# Regra para remover containers e limpar volumes
remove: down
	@$(EC) "\n🗑️ Removendo containers e volumes..."
	@$(DCK) volume prune -f
	@$(DCK) container prune -f

# Regra para parar containers parados
stop:
	@$(EC) "\n⛔ Parando containers..."
	@$(DCPS_CMD) stop

# Regra para iniciar containers parados
start:
	@$(EC) "\n▶️ Iniciando containers..."
	@$(DCPS_CMD) start

# Regra para parar e voltar a iniciar os containers
restart: stop start

# Regra para parar os servicos e limpá-los
clean: down remove

# Regra para parar e limpar tudo
fclean: clean rmsecrets rmfolder

# Regra para reconstruir e reiniciar tudo
re: fclean all

# Regra para listar containers e imagens
list:
	@$(EC) "\n📦 Listando containers:"
	@$(DCK) ps -a
	@$(EC) "\n🖼️ Listando imagens:"
	@$(DCK) images -a

# Regra para mostrar logs dos serviços
logs:
	@$(EC) "\n📜 Exibindo logs dos serviços..."
	@cd srcs && $(DCPS) logs mariadb wordpress nginx adminer website

# Verificar status dos containers
status:
	@$(EC) "\n🔍 Status dos containers:"
	@$(DCK) ps

# Alvos que não são arquivos
.PHONY: all mkfolder rmfolder mksecrets rmsecrets build up down remove stop start restart clean fclean re list logs status
