FROM	debian:bullseye

RUN		apt update -y && \
		apt install wget -y && \
		apt install php php-mysql  -y

COPY	./tools/run.sh /

CMD	["/run.sh"]
