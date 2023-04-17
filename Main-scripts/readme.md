Este arquivo define a infraestrutura básica que você precisa para este projeto: uma VPC, uma subnet, um grupo de segurança que permite conexões SSH, HTTP e HTTPS, e uma instância EC2 com Ubuntu que executa um script de provisionamento remoto para instalar o Docker, PHP 7.4 com Apache e PostgreSQL 13.

Para executar o Terraform, você deve executar os seguintes comandos na pasta onde o arquivo main.tf está localizado:

terraform init
terraform apply