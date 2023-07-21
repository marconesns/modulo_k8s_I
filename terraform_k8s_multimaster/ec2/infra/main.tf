terraform {
  required_providers {
    aws = {
      source      = "hashicorp/aws"
      version     = "5.4.0"
    }
  }
}

provider "aws" {
  region          = var.regiao_aws
}

resource "aws_instance" "haproxy" {
  ami             = var.image
  instance_type   = "t2.micro"
  key_name        = var.chave
  count           = 1
  subnet_id       = aws_subnet.subnet-k8s.id
  associate_public_ip_address = true
  tags = {
    Name = "haproxy"
  }
  vpc_security_group_ids = [ aws_security_group.k8s_sg.id ]
}

resource "aws_instance" "master" {
  ami             = var.image
  instance_type   = var.instancia
  key_name        = var.chave
  count           = 2
  subnet_id       = aws_subnet.subnet-k8s.id
  associate_public_ip_address = true
  tags = {
    Name = "master${count.index+1}"
  }
  vpc_security_group_ids = [ aws_security_group.k8s_sg.id ]
}

resource "aws_instance" "worker" {
  ami             = var.image
  instance_type   = var.instancia
  key_name        = var.chave
  subnet_id       = aws_subnet.subnet-k8s.id
  associate_public_ip_address = true
  count           = 1
  tags = {
    Name = "worker${count.index+1}"
  }
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
}

output "ec2_haproxy_map" {
  value = { for i in aws_instance.haproxy: i.tags.Name => "${i.public_ip}"}
}
output "ec2_master_map" {
  value = { for i in aws_instance.master: i.tags.Name => "${i.public_ip}"}
}

output "ec2_worker_map" {
  value = { for i in aws_instance.worker: i.tags.Name => "${i.public_ip}"}
}