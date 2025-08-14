FROM debian:bullseye-slim

RUN		apt-get update -y && \
		apt-get install -y curl && \
		curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
		apt-get install -y nodejs

COPY	./tools /home/app

WORKDIR	/home/app

RUN		npm init -y && \
		npm install express -y

EXPOSE	4444

CMD	["node", "server.js"]
