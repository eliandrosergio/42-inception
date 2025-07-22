FROM	debian:bullseye-slim

RUN		apt-get update -y && \
		apt-get upgrade -y && \
		apt-get install mariadb-server -y

COPY	./tools/run.sh /

CMD	["/run.sh"]
