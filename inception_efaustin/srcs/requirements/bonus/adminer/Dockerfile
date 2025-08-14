FROM debian:bullseye-slim

RUN		apt-get update -y && \
		apt-get upgrade -y && \
		apt-get install wget -y && \
		apt-get install php php-mysql  -y

COPY	./tools/script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]
