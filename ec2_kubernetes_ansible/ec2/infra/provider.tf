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

# resource "aws_instance" "master" {
#   ami             = var.aws_ami_id
#   instance_type   = var.ami_type
#   key_name        = var.chave
#   count           = 1
#   subnet_id       = aws_subnet.subnet-k8s.id
#   associate_public_ip_address = true
#   tags = {
#     Name = "master${count.index+1}"
#   }
#   vpc_security_group_ids = [ aws_security_group.k8s_sg.id ]
# }

resource "aws_instance" "worker" {
  ami             = var.aws_ami_id
  instance_type   = var.ami_type
  key_name        = var.chave
  subnet_id       = aws_subnet.subnet-k8s.id
  associate_public_ip_address = true
  count           = 2
  tags = {
    Name = "worker${count.index+1}"
  }
  vpc_security_group_ids = [aws_security_group.k8s_sg.id]
}

resource "aws_instance" "master" {
  ami             = var.aws_ami_id
  instance_type   = var.ami_type
  key_name        = var.chave
  count           = 1
  subnet_id       = aws_subnet.subnet-k8s.id
  associate_public_ip_address = true
  tags = {
    Name = "master${count.index+1}"
  }
  vpc_security_group_ids = [ aws_security_group.k8s_sg.id ]
  user_data       = file("../infra/user-data-ansible-master.sh")

  # copy cluster directory
  provisioner "file" {
    source      = "../../cluster"
    destination = "/home/ubuntu/cluster"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(pathexpand(var.chave))
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source = "ck-prod2"
    destination = "/home/ubuntu/.ssh/id_rsa"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(pathexpand(var.chave))
      host        = self.public_ip
      agent       = false
    }
  }

  provisioner "file" {
    source = "${var.chave}.pub"
    destination = "/home/ubuntu/.ssh/${var.chave}.pub"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(pathexpand(var.chave))
      host        = self.public_ip
      agent       = false
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 ~/.ssh/id_rsa"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(pathexpand(var.chave))
      host        = self.public_ip
      agent       = false
    }
  }
  # Create inventory and ansible.cfg on master
  provisioner "remote-exec" {
    inline = [
      "echo '[masters]' >> /home/ubuntu/inventory",
      "echo 'master ansible_host=${aws_instance.master[0].private_dns} ansible_connection=local' >> /home/ubuntu/inventory",
      "echo '[nodes]' >> /home/ubuntu/inventory",
      # "echo 'node1 ansible_host=${aws_instance.worker[0].private_dns}' >> /home/ubuntu/inventory",
      # "echo 'node2 ansible_host=${aws_instance.worker[1].private_dns}' >> /home/ubuntu/inventory",
      "echo '' >> /home/ubuntu/inventory",
      "echo '[all:vars]' >> /home/ubuntu/inventory",
      "echo 'OS=xUbuntu_22.04' >> /home/ubuntu/inventory",
      "echo 'VERSION=1.27' >> /home/ubuntu/inventory",
      "echo 'WEAVE_VERSION=v2.8.1' >> /home/ubuntu/inventory",
      "echo 'ansible_user=ubuntu' >> /home/ubuntu/inventory",
      "echo 'ansible_connection=ssh' >> /home/ubuntu/inventory",
      "echo '#ansible_python_interpreter=/usr/bin/python3' >> /home/ubuntu/inventory",
      "echo 'ansible_ssh_private_key_file=/home/ubuntu/.ssh/id_rsa' >> /home/ubuntu/inventory",
      "echo \"ansible_ssh_extra_args=' -o StrictHostKeyChecking=no -o PreferredAuthentications=password '\" >> /home/ubuntu/inventory",
      "echo '[defaults]' >> /home/ubuntu/ansible.cfg",
      "echo 'inventory = ./inventory' >> /home/ubuntu/ansible.cfg",
      "echo 'host_key_checking = False' >> /home/ubuntu/ansible.cfg",
      "echo 'remote_user = ubuntu' >> /home/ubuntu/ansible.cfg",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(pathexpand(var.chave))
      host        = self.public_ip
      agent       = false
    }
  }

  
  # Execute Ansible Playbook
  # provisioner "remote-exec" {
  #   inline = [
  #     # "sleep 120; ansible-playbook engine-config.yaml"
  #     "sleep 20; ansible-playbook cluster/main.yml -v"
  #   ]
  #   connection {
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = file(pathexpand(var.chave))
  #     host        = self.public_ip
  #   }
  # }

}

# output "ec2_master_map" {
#   value = { for i in aws_instance.master: i.tags.Name => "${i.public_ip}"}
# }  

output "ec2_master_map" {
  value = { for i in aws_instance.master: i.tags.Name => "${i.public_ip}"}
}

output "ec2_worker_map" {
  value = { for i in aws_instance.worker: i.tags.Name => "${i.public_ip}"}
}