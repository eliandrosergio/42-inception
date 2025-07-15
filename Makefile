# Makefile para o projeto Inception

all: build up

build:
	#@mkdir -p /home/$(USER)/data/wordpress
	#@mkdir -p /home/$(USER)/data/database
	@docker-compose -f ./srcs/docker-compose.yml build

up:
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

clean:
	@docker-compose -f ./srcs/docker-compose.yml down -v
	@docker system prune -f

fclean: clean
	#@rm -rf /home/$(USER)/data/wordpress/*
	#@rm -rf /home/$(USER)/data/database/*

re: fclean all

.PHONY: all build up down clean fclean re
