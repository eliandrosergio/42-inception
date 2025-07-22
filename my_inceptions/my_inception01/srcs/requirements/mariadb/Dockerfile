FROM	debian:bullseye

RUN		apt-get update -yq && \
		apt-get upgrade -y && \
		apt-get install mariadb-server mariadb-client -y

COPY	./tools/run.sh /tmp/

COPY	./conf/init.sql /tmp/

COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

ENTRYPOINT ["sh", "/tmp/run.sh"]
