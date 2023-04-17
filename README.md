# Desafio-Magazord

<!DOCTYPE html>
<html>
<head>
	<h2>Thiago Martins e Martins</h2>
</head>
<body>
	<h1>Passo a passo do Projeto:</h1>
	<h2>Criação da Infraestrutura na AWS usando Terraform:</h2>
	<ul>
		<li>Foram criados os arquivos main.tf e variables.tf para definir a infraestrutura como código;</li>
		<li>Foi definida a criação da Virtual Private Cloud (VPC) com sub-redes públicas e privadas;</li>
		<li>Foi definida a criação da instância EC2 com uma Security Group que permite acesso ao SSH e HTTP;</li>
		<li>Foi definido o provisionamento da instância EC2 com a instalação do Docker, PostgreSQL e criação de um script Python para backup do banco de dados PostgreSQL.</li>
	</ul>
	<h2>Publicação de uma página PHP na instância EC2:</h2>
	<ul>
		<li>Foi criado um container Docker com Apache e PHP;</li>
		<li>Foi publicada uma página PHP no container com o comando docker cp;</li>
		<li>Foi testado o acesso à página PHP no navegador.</li>
	</ul>
	<h2>Configuração do PostgreSQL para responder apenas às requisições da máquina local:</h2>
	<ul>
		<li>Foi editado o arquivo pg_hba.conf para permitir acesso apenas à rede local.</li>
	</ul>
	<h2>Criação do banco de dados e inserção de dados:</h2>
	<ul>
		<li>Foi executado um script SQL para criar um banco de dados e uma tabela com um milhão de registros.</li>
	</ul>
	<h2>Criação do script Python para backup do banco de dados e armazenamento no S3:</h2>
	<ul>
		<li>Foi criado o arquivo s3script.py com as configurações do S3 e do PostgreSQL;</li>
		<li>O script realiza o backup do banco de dados e armazena o arquivo no S3.</li>
	</ul>
	<h2>Construção do projeto no Jenkins:</h2>
	<ul>
		<li>Foi criado um arquivo Jenkinsfile com o pipeline de execução das etapas do projeto;</li>
		<li>O pipeline realiza o download do backup do S3, extrai o arquivo e copia a página PHP para o container;</li>
		<li>O pipeline reinicia o container com a página PHP atualizada.</li>
	</ul>
	<p>Observação: Foi utilizado o Amazon Linux 2 como sistema operacional da instância EC2. Para executar o script Python, foi necessário instalar as bibliotecas psycopg2 e boto3. O Jenkins foi executado em um container Docker. O uso do AWS ECS para o Jenkins foi sugerido como um diferencial, mas não foi implementado neste projeto.</p>
</body>
</html>
