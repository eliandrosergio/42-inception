#!/bin/bash

# Este comando gera um certificado SSL/TLS autoassinado e uma chave privada usando OpenSSL.
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/L=França/O=42/OU=student/CN=[$DOMAIN_NAME](http://$DOMAIN_NAME/)"

echo "
server {
	# O servidor escuta conexões de entrada na porta 443, que é a porta padrão para tráfego HTTPS. O servidor escuta conexões IPv4 e IPv6.
	listen 443 ssl;
	listen [::]:443 ssl;

	# definindo o server_name pra o nosso DOMAIN_NAME
	server_name www.$DOMAIN_NAME $DOMAIN_NAME;

	# As diretivas ssl_certificate e ssl_certificate_key especificam os locais do certificado SSL/TLS e da chave privada, respectivamente, que serão usados para criptografar o tráfego. A diretiva ssl_protocols especifica os protocolos TLS que o servidor deve suportar.
	ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
	ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;" > /etc/nginx/sites-available/default

echo '
	# Estamos usando a versão 1.3 do TLS
	ssl_protocols TLSv1.3;

	# A diretiva index especifica o arquivo padrão que deve ser exibido quando um cliente solicita um diretório no servidor. A diretiva root especifica o diretório raiz que deve ser usado para pesquisar arquivos.
	index index.php;
	root /var/www/wordpress;

	# A diretiva location define um bloco de configuração que se aplica a um local específico, especificado por meio de uma expressão regular. Nesse caso, a expressão regular ~ [^/]\\.php(/|$) corresponde a qualquer solicitação que termine em .php e não seja precedida pelo caractere /.
	location ~ [^/]\\.php(/|$) {
		# A diretiva try_files tenta servir o arquivo solicitado e, se ele não existir, retornará um erro 404.
		try_files $uri =404;

		# A diretiva fastcgi_pass passa a solicitação para um servidor FastCGI para processamento.
		fastcgi_pass wordpress:9000;

		# A diretiva include inclui um arquivo com parâmetros FastCGI.
		include fastcgi_params;

		# A diretiva fastcgi_param define um parâmetro FastCGI. O parâmetro SCRIPT_FILENAME especifica o caminho para o script PHP que deve ser executado.
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
	}
} ' >> /etc/nginx/sites-available/default

nginx -g "daemon off;"
