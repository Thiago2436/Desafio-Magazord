import boto3
import subprocess
import os

# Configuração do S3
bucket_name = 'backup-bucket'
s3 = boto3.resource('s3')

# Configuração do PostgreSQL
user = 'postgres'
password = 'senha-do-postgres'
host = 'localhost'
port = '5432'
db_name = 'testdb'

# Comando para gerar o backup
backup_cmd = f"PGPASSWORD={password} pg_dump -h {host} -p {port} -U {user} -F t {db_name} > /tmp/backup.tar"

# Executa o comando para gerar o backup
subprocess.run(backup_cmd, shell=True)

# Faz upload do backup para o S3
backup_key = 'backup.tar'
s3.meta.client.upload_file('/tmp/backup.tar', bucket_name, backup_key)

# Remove o arquivo temporário
os.remove('/tmp/backup.tar')
