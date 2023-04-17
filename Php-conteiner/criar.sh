#!/bin/sh

# Cria um novo diretório para o projeto e navega até ele
mkdir my-php-app
cd my-php-app

# Cria um arquivo index.php com a mensagem "Hello World!"
echo "<?php echo 'Hello World!'; ?>" > index.php

# Cria um arquivo Dockerfile com as instruções para criar a imagem Docker
echo "FROM php:7.4-apache\nCOPY ./index.php /var/www/html/" > Dockerfile

# Cria e executa o container Docker com a imagem criada
docker build -t my-php-app .
docker run -p 80:80 -d my-php-app
