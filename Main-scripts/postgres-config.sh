#!/bin/bash

# Adiciona a linha "host    all             all             127.0.0.1/32            md5" ao arquivo pg_hba.conf para permitir conexões somente da máquina local (localhost)
sudo echo "host    all             all             127.0.0.1/32            md5" >> /etc/postgresql/13/main/pg_hba.conf

# Reinicia o serviço do PostgreSQL para que as alterações entrem em vigor
sudo systemctl restart postgresql
