#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker.service
sudo systemctl enable docker.service
usermod -a -G docker ec2-user
sudo yum install glibc
sudo yum install python-pip
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo mv /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
pip install docker-compose
sudo yum -y install amazon-efs-utils
sudo mkdir /mnt/efs
sudo mount -t efs fs-04018cce06b98d***:/ /mnt/efs
mkdir -p /docker
sudo cat <<EOL > /docker/docker-compose.yml
version: '3.4'

services:
  wordpress:
    image: wordpress:latest
    ports:
      - 80:80
    volumes:
      - /mnt/efs:/var/www/html
    environment:
      WORDPRESS_DB_HOST: wordpress-2.c9qu8ieoimo7.us-east-1.rds.amazonaws.com
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_USER: admin
      WORDPRESS_DB_PASSWORD: ********
EOL
chown -R ec2-user:ec2-user /docker
docker-compose -f /docker/docker-compose.yml up -d


