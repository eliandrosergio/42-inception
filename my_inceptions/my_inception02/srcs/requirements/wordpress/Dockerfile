FROM	debian:bullseye-slim

RUN		apt-get update -y && \
		apt-get upgrade -y && \
		apt update -y && \
		apt upgrade -y && \
		apt install php-fpm php-mysql -y && \
		apt install curl -y

COPY	./tools/run.sh /

CMD	["/run.sh"]
