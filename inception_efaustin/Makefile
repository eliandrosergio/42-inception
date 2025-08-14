# My var(s)
NAME			=	inception
RM				=	rm -rf
MK				=	mkdir -p

TEMP_ENV		=	./srcs/.env.temp
ENV_FILES		=	./srcs/.env ./srcs/.env.credentials

DCK				=	docker
DCPS			=	docker-compose
DCPS_CMD		=	$(DCPS) --env-file $(TEMP_ENV) -f ./srcs/docker-compose.yml

DT_DIR			=	/home/efaustin/data
DB_DIR			=	$(DT_DIR)/mariadb
WP_DIR			=	$(DT_DIR)/wordpress
ADMINER_DIR		=	$(DT_DIR)/adminer
SECRETS_DIR		=	./secrets

SENHAS_FILES	=	secrets/credentials.txt secrets/db_password.txt secrets/db_root_password.txt srcs/.env.credentials

# My rule(s)
all: check_files mkfolder build up

check_files:
	@echo "\n🔍 Verificando a existência das credenciais..."
	@for file in $(SENHAS_FILES); do \
		if [ ! -f $$file ]; then \
			echo "❌ Arquivo obrigatório das credenciais não encontrado: $$file"; \
			exit 1; \
		fi; \
	done
	@echo "✅ Todos os arquivos obrigatórios das credenciais existem."

mkfolder:
	@echo "\n📁 Criando os diretórios dos volumes..."
	@$(MK) $(DT_DIR)
	@$(MK) $(DB_DIR)
	@$(MK) $(WP_DIR)
	@$(MK) $(ADMINER_DIR)
	@$(MK) $(SECRETS_DIR)
	@echo "✅ Diretórios dos volumes prontos com permissões."

build:
	@cat $(ENV_FILES) > $(TEMP_ENV)
	@echo "\n🔨 Construindo imagens do Docker..."
	@$(DCPS_CMD) build
	@echo "✅ Imagens do Docker construidas"

up:
	@echo "\n🚀 Iniciando serviços..."
	@$(DCPS_CMD) up -d

down:
	@echo "\n🛑 Parando serviços..."
	@$(DCPS_CMD) down

remove: down
	@echo "\n🗑️ Removendo containers e volumes..."
	@$(DCK) volume prune -f
	@$(DCK) container prune -f

stop:
	@echo "\n⛔ Parando containers..."
	@$(DCPS_CMD) stop

start:
	@echo "\n▶️ Iniciando containers..."
	@$(DCPS_CMD) start

restart: stop start

clean: stop down
	@$(RM) $(TEMP_ENV)

fclean: clean remove

re: fclean all

list:
	@echo "\n📦 Listando containers:"
	@$(DCK) ps -a
	@echo "\n🖼️ Listando imagens:"
	@$(DCK) images -a

logs:
	@echo "\n📜 Exibindo logs dos serviços..."
	@echo "\n================ mariadb ================"
	@cd srcs && $(DCPS) logs mariadb
	@echo "\n================ wordpress =============="
	@cd srcs && $(DCPS) logs wordpress
	@echo "\n================ nginx =================="
	@cd srcs && $(DCPS) logs nginx
	@echo "\n================ adminer ================"
	@cd srcs && $(DCPS) logs adminer
	@echo "\n================ website ================"
	@cd srcs && $(DCPS) logs website

status:
	@echo "\n🔍 Status dos containers:"
	@$(DCK) ps

help:
	@echo "Use: make [OPÇÃO] | Opção padrão: all"
	@echo "\nOpções:"
	@echo "\nall	= 🔨 construir e 🚀 iniciar o projeto"
	@echo "clean	= ⛔ parar os servicos e 🗑️ limpá-los"
	@echo "fclean	= ⛔ parar e 🗑️ limpar tudo"
	@echo "re	= 🔨 reconstruir e 🚀 reiniciar tudo"
	@echo "\ncheck_files = 🔍 Verifica a existência das credenciais"
	@echo "mkfolder    = 📁 cria os diretórios dos volumes"
	@echo "build	    = 🔨 construindo imagens do Docker"
	@echo "up	    = 🚀 inicia os serviços em modo detached"
	@echo "down	    = 🛑 para e remove os serviços"
	@echo "remove	    = 🗑️ remove containers e volumes"
	@echo "\nstop	= ⛔ para os containers"
	@echo "start	= ▶️ inicia os containers"
	@echo "restart	= ⛔ para e volta a ▶️ iniciar os containers"
	@echo "\nlist	= lista 📦 containers e 🖼️ imagens"
	@echo "logs	= exibi 📜 logs dos serviços"
	@echo "status	= mostra 🔍 status dos containers"

# Alvos que não são arquivos
.PHONY: all check_files mkfolder build up down remove stop start restart clean fclean re list logs status help
