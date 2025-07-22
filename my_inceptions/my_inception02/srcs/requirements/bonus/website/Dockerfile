FROM	debian:bullseye-slim

RUN		apt update -y && \
		apt upgrade -y && \
		apt install nodejs npm -y

COPY	./tools /home/app

WORKDIR	/home/app

RUN		npm init -y && \
		npm install express -y

CMD	["node", "server.js"]
