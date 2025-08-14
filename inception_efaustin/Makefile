-include .env

# My var(s)
NAME			=	inception
EC				=	echo
RM				=	rm -rf
MK				=	mkdir -p

DCK				=	docker
DCPS			=	docker-compose
DCPS_CMD		=	$(DCPS) -f ./srcs/docker-compose.yml

DT_DIR			=	/home/efaustin/data
DB_DIR			=	$(DT_DIR)/mariadb
WP_DIR			=	$(DT_DIR)/wordpress
ADMINER_DIR		=	$(DT_DIR)/adminer
SECRETS_DIR		=	./secrets

# My rule(s)
all: mkfolder mksecrets build up

mkfolder:
	@$(EC) "\n📁 Criando os diretórios dos volumes..."
	@$(MK) $(DT_DIR)
	@$(MK) $(DB_DIR)
	@$(MK) $(WP_DIR)
	@$(MK) $(ADMINER_DIR)
	@$(EC) "✅ Diretórios dos volumes prontos com permissões."

mksecrets:
	@$(EC) "\n🔐 Criando arquivos de secrets..."
	@$(MK) $(SECRETS_DIR)
	@$(EC) "$(DB_PASS)" > $(SECRETS_DIR)/db_pass.txt
	@$(EC) "$(DB_RTPASS)" > $(SECRETS_DIR)/db_root_pass.txt
	@$(EC) "$(WP_PASS)" > $(SECRETS_DIR)/wp_editor_pass.txt
	@$(EC) "$(WP_PASS2)" > $(SECRETS_DIR)/wp_user_pass.txt
	@$(EC) "✅ Arquivos de secrets criados."

rmsecrets:
	@$(EC) "\n🧨 Removendo arquivos de secrets..."
	@$(RM) $(SECRETS_DIR)/*
	@$(EC) "✅ Arquivos de secrets removidos."

build:
	@$(EC) "\n🔨 Construindo imagens do Docker..."
	@$(DCPS_CMD) build

up:
	@$(EC) "\n🚀 Iniciando serviços..."
	@$(DCPS_CMD) up -d

down:
	@$(EC) "\n🛑 Parando serviços..."
	@$(DCPS_CMD) down

remove: down
	@$(EC) "\n🗑️ Removendo containers e volumes..."
	@$(DCK) volume prune -f
	@$(DCK) container prune -f

stop:
	@$(EC) "\n⛔ Parando containers..."
	@$(DCPS_CMD) stop

start:
	@$(EC) "\n▶️ Iniciando containers..."
	@$(DCPS_CMD) start

restart: stop start

clean: down remove

fclean: clean rmsecrets

re: fclean all

list:
	@$(EC) "\n📦 Listando containers:"
	@$(DCK) ps -a
	@$(EC) "\n🖼️ Listando imagens:"
	@$(DCK) images -a

logs:
	@$(EC) "\n📜 Exibindo logs dos serviços..."
	@cd srcs && $(DCPS) logs mariadb wordpress nginx adminer website

status:
	@$(EC) "\n🔍 Status dos containers:"
	@$(DCK) ps

help:
	@$(EC) "Use: make [OPÇÃO] | Opção padrão: all"
	@$(EC) "\nOpções:"
	@$(EC) "\nall	= 🔨 construir e 🚀 iniciar o projeto"
	@$(EC) "clean	= ⛔ parar os servicos e 🗑️ limpá-los"
	@$(EC) "fclean	= ⛔ parar e 🗑️ limpar tudo"
	@$(EC) "re	= 🔨 reconstruir e 🚀 reiniciar tudo"
	@$(EC) "\nmkfolder  = 📁 cria os diretórios dos volumes"
	@$(EC) "mksecrets = 🔐 cria arquivos de secrets"
	@$(EC) "rmsecrets = 🧨 remove arquivos de secrets"
	@$(EC) "\nbuild	= 🔨 construindo imagens do Docker"
	@$(EC) "up	= 🚀 inicia os serviços em modo detached"
	@$(EC) "down	= 🛑 para e remove os serviços"
	@$(EC) "remove	= 🗑️ remove containers e volumes"
	@$(EC) "\nstop	= ⛔ para os containers"
	@$(EC) "start	= ▶️ inicia os containers"
	@$(EC) "restart	= ⛔ para e volta a ▶️ iniciar os containers"
	@$(EC) "\nlist	= lista 📦 containers e 🖼️ imagens"
	@$(EC) "logs	= exibi 📜 logs dos serviços"
	@$(EC) "status	= mostra 🔍 status dos containers"

# Alvos que não são arquivos
.PHONY: all mkfolder mksecrets rmsecrets build up down remove stop start restart clean fclean re list logs status help
