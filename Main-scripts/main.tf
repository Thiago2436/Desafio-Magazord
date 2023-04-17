provider "aws" {
  region = "us-east-1"
}

resource "null_resource" "postgresql_setup" {
  provisioner "file" {
    content = file("postgresql-setup.sh")
    destination = "/tmp/postgresql-setup.sh"
    connection {
      type = "ssh"
      user = var.instance_username
      private_key = file(var.ssh_private_key_path)
      host = aws_instance.my_instance.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/postgresql-setup.sh",
      "sudo /tmp/postgresql-setup.sh"
    ]
    connection {
      type = "ssh"
      user = var.instance_username
      private_key = file(var.ssh_private_key_path)
      host = aws_instance.my_instance.public_ip
    }
  }
}

// Este recurso utiliza dois provisioners: file para copiar o arquivo .sh para a instância EC2 e remote-exec para executar o script na instância. 
//Os valores de var.instance_username e var.ssh_private_key_path devem ser definidos no seu arquivo Terraform como postgresql-setup.sh 
//Note que o script .sh é copiado para o diretório /tmp da instância EC2 e executado com privilégios de superusuário (sudo).

//Com esses recursos adicionados, o script .sh será executado durante a criação da instância EC2 e o PostgreSQL será instalado e configurado com o banco de dados, tabela e dados de teste criados.

resource "null_resource" "postgresql_config" {
  provisioner "file" {
    content = file("postgresql-config.sh")
    destination = "/tmp/postgresql-config.sh"
    connection {
      type = "ssh"
      user = var.instance_username
      private_key = file(var.ssh_private_key_path)
      host = aws_instance.my_instance.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/postgresql-config.sh",
      "sudo /tmp/postgresql-config.sh"
    ]
    connection {
      type = "ssh"
      user = var.instance_username
      private_key = file(var.ssh_private_key_path)
      host = aws_instance.my_instance.public_ip
    }
  }
}

// Com esse recurso adicionado, o script .sh será executado durante a criação da instância EC2 e o arquivo pg_hba.conf será configurado para permitir conexões somente da máquina local (localhost). 
//O serviço do PostgreSQL será reiniciado para que as alterações entrem em vigor.


resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "web" {
  name_prefix = "web"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "backup-bucket" {
  bucket = "backup-bucket"
  acl    = "private"
}

resource "aws_instance" "ec2" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  key_name      = "your-key-pair-name"
  subnet_id     = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.web.id]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/your-key-pair-name.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ubuntu",
      "sudo docker pull php:7.4-apache",
      "sudo docker pull postgres:13",
    ]
  }

  provisioner "local-exec" {
    command = "sleep 60"
  }

  tags = {
    Name = "ec2-instance"
  }
}
