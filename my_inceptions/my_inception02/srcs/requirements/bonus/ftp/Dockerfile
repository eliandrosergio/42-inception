FROM	debian:bullseye-slim

RUN		apt update -y && \
		apt install vsftpd -y

COPY	./tools/run.sh /

CMD	["/run.sh"]
