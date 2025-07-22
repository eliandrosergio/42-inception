FROM	debian:bullseye

RUN		apt update -y && \
		apt upgrade -y && \
		apt install -y nginx && \
		apt install openssl -y

COPY	./tools/run.sh /

CMD	["/run.sh"]
