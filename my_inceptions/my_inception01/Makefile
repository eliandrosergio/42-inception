EC			=	echo
DOC			=	docker
DOCCOMP		=	docker-compose
COMP_FILE	=	./srcs/docker-compose.yml
DOCCOMP_CMD	=	$(DOCCOMP) -f $(COMP_FILE)

all: build up

build:
	@$(EC) "Construindo as imagens do Docker..."
	@$(DOCCOMP_CMD) build

up:
	@$(EC) "Iniciando os serviços..."
	@$(DOCCOMP_CMD) up -d

start:
	@$(EC) "Iniciando os containers..."
	@$(DOCCOMP_CMD) start

stop:
	@$(EC) "Parando os containers..."
	@$(DOCCOMP_CMD) stop

down:
	@$(EC) "Removendo os serviços..."
	@$(DOCCOMP_CMD) down

destroy:
	@$(EC) "Destruíndo os containers e os volumes..."
	@$(DOC) volume prune -f
	@$(DOC) container prune -f

re: destroy all

list:
	@$(EC) "Listando os containers..."
	@$(DOC) ps -a
	@$(EC) "Listando as imagens..."
	@$(DOC) images -a

logs:
	@$(EC) "Exibindo os logs dos serviços..."
	@cd srcs && $(DOCCOMP) logs mariadb wordpress nginx

.PHONY: all build up start stop down destroy re list logs
