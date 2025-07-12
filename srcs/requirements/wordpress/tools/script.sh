#!/bin/bash
#efaustin

# criando um diretório para usar no contêiner nginx mais tarde e também para configurar a configuração do wordpress
mkdir /var/www/
mkdir /var/www/html

cd /var/www/html

# removendo todos os arquivos do wordpress se houver algo dos volumes para instalá-lo novamente
rm -rf *

# baixando o arquivo WP-CLI PHAR (arquivo PHP) do repositório do GitHub. O sinalizador -O informa ao curl para salvar o arquivo com o mesmo nome que ele tem no servidor
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

# torna o arquivo WP-CLI PHAR executável
chmod +x wp-cli.phar 

# movendo o arquivo WP-CLI PHAR para o diretório /usr/local/bin, que está no PATH do sistema, e o renomeia para wp. Permitindo executar o comando wp de qualquer diretório
mv wp-cli.phar /usr/local/bin/wp

# baixando a versão mais recente do WordPress para o diretório atual. A flag --allow-root permite que o comando seja executado como usuário root, o que é necessário para o usuário root ou se estiver usando o WP-CLI com uma instalação do WordPress em nível de sistema
wp core download --allow-root

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

mv /wp-config.php /var/www/html/wp-config.php

# altere essas linhas no arquivo wp-config.php para conectar com o banco de dados

#linha 23
sed -i -r "s/efaustindb/$db_name/1"	wp-config.php

#linha 26
sed -i -r "s/efaustin/$db_user/1" 	wp-config.php

#linha 29
sed -i -r "s/efaustinsenha/$db_pwd/1"	wp-config.php

# instalando o WordPress e define a configuração básica do site. A opção --url especifica a URL do site, --title define o título do site, --admin_user e --admin_password definem o nome de usuário e a senha da conta de administrador do site, e --admin_email define o endereço de e-mail do administrador. A flag --skip-email impede que o WP-CLI envie um e-mail ao administrador com os detalhes de login. A flag --allow-root permite que o comando seja executado como usuário root
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# criando uma nova conta de usuário com o nome de usuário, endereço de e-mail e senha especificados. A opção --role define a função do usuário como autor, o que lhe dá a capacidade de publicar e gerenciar suas próprias postagens
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# instalando o tema Astra e o ativa para o site. O sinalizador --activate informa ao WP-CLI para tornar o tema o tema ativo para o site
wp theme install astra --activate --allow-root

wp plugin install redis-cache --activate --allow-root

wp plugin update --all --allow-root

# usando o comando sed para modificar o arquivo www.conf no diretório /etc/php/7.3/fpm/pool.d. O comando s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g substitui o valor 9000 por /run/php/php7.3-fpm.sock em todo o arquivo. Isso altera o soquete em que o PHP-FPM escuta de um soquete de domínio Unix para uma porta TCP
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

# criando o diretório /run/php, que é usado pelo PHP-FPM para armazenar soquetes de domínio Unix
mkdir /run/php

wp redis enable --allow-root

# iniciando o serviço PHP-FPM em primeiro plano. O sinalizador -F informa ao PHP-FPM para ser executado em primeiro plano, em vez de como um daemon em segundo plano
/usr/sbin/php-fpm7.3 -F
