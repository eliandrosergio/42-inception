#!/bin/bash

# crie um diretório para usar no contêiner nginx mais tarde e também para configurar a configuração do wordpress

conf
mkdir /var/www/
mkdir /var/www/wordpress

cd /var/www/wordpress

# remova todos os arquivos do wordpress se houver algo dos volumes para instalá-lo novamente
again
rm -rf *

# Os comandos são para instalar e usar a ferramenta WP-CLI.

# baixa o arquivo WP-CLI PHAR (arquivo PHP) do repositório do GitHub. O sinalizador -O informa ao curl para salvar o arquivo com o mesmo nome que ele tem no servidor.
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# torna o arquivo WP-CLI PHAR executável.
chmod +x wp-cli.phar 

# move o arquivo WP-CLI PHAR para o diretório /usr/local/bin, que está no PATH do sistema, e o renomeia para wp. Isso permite que você execute o comando wp de qualquer diretório
mv wp-cli.phar /usr/local/bin/wp

# baixa a versão mais recente do WordPress para o diretório atual. A opção --allow-root permite que o comando seja executado como usuário root, o que é necessário se você estiver logado como usuário root ou se estiver usando o WP-CLI com uma instalação do WordPress em nível de sistema.
wp core download --allow-root
mv /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php

# altere essas linhas no arquivo wp-config.php para conectar com o banco de dados, e para conectar com o mariadb

#linha 23
sed -i -r "s/database/$MYSQL_DB/1" wp-config.php
#linha 26
sed -i -r "s/database_user/$MYSQL_USER/1" wp-config.php
#linha 29
sed -i -r "s/passwod/$MYSQL_PASS/1" wp-config.php
#linha 32
sed -i -r "s/localhost/mariadb/1" wp-config.php

# instala o WordPress e define a configuração básica do site. A opção --url especifica a URL do site, --title define o título do site, --admin_user e --admin_password definem o nome de usuário e a senha da conta de administrador do site, e --admin_email define o endereço de e-mail do administrador. A flag--skip-email impede que o WP-CLI envie um e-mail ao administrador com os detalhes de login.
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_PASS --admin_email=$WP_EMAIL --skip-email --allow-root

# cria uma nova conta de usuário com o nome de usuário, endereço de e-mail e senha especificados. A opção --role define a função do usuário como autor, o que lhe dá a capacidade de publicar e gerenciar suas próprias postagens.
wp user create $WP_USER2 $WP_EMAIL2 --role=author --user_pass=$WP_PASS2 --allow-root

# instala o tema Astra e o ativa para o site. O sinalizador --activate informa ao WP-CLI para tornar o tema o tema ativo para o site.
wp theme install astra --activate --allow-root
wp plugin install redis-cache --activate --allow-root

# usa o comando sed para modificar o arquivo www.conf no diretório /etc/php/7.3/fpm/pool.d. O comando s|listen = /run/php/php73-fpm.sock|listen = 9000|g substitui o valor 9000 por /run/php/php73-fpm.sock em todo o arquivo. Isso altera o soquete em que o PHP-FPM escuta de um soquete de domínio Unix para uma porta TCP.
sed -i 's|listen = /run/php/php73-fpm.sock|listen = 9000|g' /etc/php/7.3/fpm/pool.d/www.conf

# cria o diretório /run/php, que é usado pelo PHP-FPM para armazenar soquetes de domínio Unix
mkdir /run/php
wp redis enable --allow-root

# inicia o serviço PHP-FPM em primeiro plano. O sinalizador -F informa ao PHP-FPM para ser executado em primeiro plano, em vez de como um daemon em segundo plano.
/usr/sbin/php-fpm7.3 -F
