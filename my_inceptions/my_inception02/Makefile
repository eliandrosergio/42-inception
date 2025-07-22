EC			=	echo
DOC			=	docker
RMD			=	rm -rf
MKD			=	mkdir -p
CHM			=	chmod 777
DOCCOMP_CMD	=	docker-compose -f ./srcs/docker-compose.yml

all: mkfolder build up

mkfolder:
	@$(EC) "\nCriando os diretórios do projecto..."
	@$(MKD) /home/elian/data
	@$(MKD) /home/elian/data/mariadb
	@$(MKD) /home/elian/data/wordpress
	@$(CHM) /home/elian/data
	@$(CHM) /home/elian/data/mariadb
	@$(CHM) /home/elian/data/wordpress
	@$(EC) "Diretórios do projecto criados"

rmfolder:
	@$(EC) "\nLimpando os diretórios do projecto..."
	@$(RMD) /home/elian/data
	@$(RMD) /home/elian/data/mariadb
	@$(RMD) /home/elian/data/wordpress
	@$(EC) "Diretórios do projecto limpos"

build:
	@$(EC) "\nConstruindo as imagens do Docker..."
	@$(DOCCOMP_CMD) build

up:
	@$(EC) "\nIniciando os serviços..."
	@$(DOCCOMP_CMD) up -d

start:
	@$(EC) "\nIniciando os containers..."
	@$(DOCCOMP_CMD) start

stop:
	@$(EC) "\nParando os containers..."
	@$(DOCCOMP_CMD) stop

down:
	@$(EC) "\nRemovendo os serviços..."
	@$(DOCCOMP_CMD) down

destroy: down
	@$(EC) "\nDestruíndo os containers e os volumes..."
	@$(DOC) volume prune -f
	@$(DOC) container prune -f

fclean: destroy rmfolder

re: fclean all

list:
	@$(EC) "\nListando os containers..."
	@$(DOC) ps -a
	@$(EC) "\nListando as imagens..."
	@$(DOC) images -a

logs:
	@$(EC) "\nExibindo os logs dos serviços..."
	@cd srcs && docker-compose logs mariadb wordpress nginx

.PHONY: mkfolder rmfolder all build up start stop down destroy fclean re list logs
