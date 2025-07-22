EC			=	echo
DOC			=	docker
RMD			=	rm -rf
MKD			=	mkdir -p
CHM			=	chmod 755
DOCCOMP_CMD	=	docker-compose -f ./srcs/docker-compose.yml
DATA_DIR	=	/home/elian/data

# Cores para output
GREEN		=	\033[0;32m
YELLOW		=	\033[0;33m
RED			=	\033[0;31m
NC			=	\033[0m

all: mkfolder build up

mkfolder:
	@$(EC) "$(YELLOW)📁 Criando os diretórios do projecto...$(NC)"
	@$(MKD) $(DATA_DIR)
	@$(MKD) $(DATA_DIR)/mariadb
	@$(MKD) $(DATA_DIR)/wordpress
	@$(CHM) $(DATA_DIR)
	@$(CHM) $(DATA_DIR)/mariadb
	@$(CHM) $(DATA_DIR)/wordpress
	@$(EC) "$(GREEN)✅ Diretórios do projecto criados$(NC)"

rmfolder:
	@$(EC) "$(RED)🧹 Limpando os diretórios do projecto...$(NC)"
	@$(RMD) $(DATA_DIR)
	@$(EC) "$(GREEN)✅ Diretórios do projecto limpos$(NC)"

build:
	@$(EC) "$(YELLOW)🔨 Construindo as imagens do Docker...$(NC)"
	@$(DOCCOMP_CMD) build --no-cache

up:
	@$(EC) "$(YELLOW)🚀 Iniciando os serviços...$(NC)"
	@$(DOCCOMP_CMD) up -d

start:
	@$(EC) "$(YELLOW)▶️  Iniciando os containers...$(NC)"
	@$(DOCCOMP_CMD) start

stop:
	@$(EC) "$(RED)⏹️  Parando os containers...$(NC)"
	@$(DOCCOMP_CMD) stop

restart: stop start

down:
	@$(EC) "$(RED)⬇️  Removendo os serviços...$(NC)"
	@$(DOCCOMP_CMD) down

destroy: down
	@$(EC) "$(RED)💥 Destruindo containers, volumes e imagens...$(NC)"
	@$(DOC) system prune -af --volumes
	@$(EC) "$(GREEN)✅ Sistema Docker limpo$(NC)"

fclean: destroy rmfolder

re: fclean all

status:
	@$(EC) "$(YELLOW)📊 Status dos containers:$(NC)"
	@$(DOC) ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

logs:
	@$(EC) "$(YELLOW)📋 Exibindo os logs dos serviços...$(NC)"
	@$(DOCCOMP_CMD) logs --tail=50 -f

logs-service:
	@$(EC) "$(YELLOW)📋 Logs do serviço [$(SERVICE)]:$(NC)"
	@$(DOCCOMP_CMD) logs --tail=100 -f $(SERVICE)

images:
	@$(EC) "$(YELLOW)🖼️  Imagens Docker:$(NC)"
	@$(DOC) images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedAt}}"

volumes:
	@$(EC) "$(YELLOW)💾 Volumes Docker:$(NC)"
	@$(DOC) volume ls

networks:
	@$(EC) "$(YELLOW)🌐 Redes Docker:$(NC)"
	@$(DOC) network ls

shell-nginx:
	@$(DOC) exec -it nginx /bin/bash

shell-wordpress:
	@$(DOC) exec -it wordpress /bin/bash

shell-mariadb:
	@$(DOC) exec -it mariadb /bin/bash

help:
	@$(EC) "$(GREEN)🆘 Comandos disponíveis:$(NC)"
	@$(EC) "  $(YELLOW)all$(NC)         - Criar pastas, build e executar"
	@$(EC) "  $(YELLOW)build$(NC)       - Construir as imagens"
	@$(EC) "  $(YELLOW)up$(NC)          - Iniciar os serviços"
	@$(EC) "  $(YELLOW)down$(NC)        - Parar os serviços"
	@$(EC) "  $(YELLOW)restart$(NC)     - Reiniciar containers"
	@$(EC) "  $(YELLOW)status$(NC)      - Ver status dos containers"
	@$(EC) "  $(YELLOW)logs$(NC)        - Ver logs de todos serviços"
	@$(EC) "  $(YELLOW)logs-service SERVICE=nome$(NC) - Ver logs de um serviço"
	@$(EC) "  $(YELLOW)shell-*$(NC)     - Acesso shell aos containers"
	@$(EC) "  $(YELLOW)fclean$(NC)      - Limpeza completa"
	@$(EC) "  $(YELLOW)re$(NC)          - Rebuild completo"

.PHONY: mkfolder rmfolder all build up start stop restart down destroy fclean re status logs logs-service images volumes networks shell-nginx shell-wordpress shell-mariadb help
