#! /bin/bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install -y ansible
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo systemctl restart sshd.service
sudo apt install -y python3
sudo apt install -y vim
# sudo apt update -y