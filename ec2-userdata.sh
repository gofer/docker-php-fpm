#!/bin/sh

set -xe

yum update && yum upgrade

yum install -y git docker tmux

systemctl enable docker && systemctl start docker

usermod -aG docker ec2-user

su ec2-user

cd /home/ec2-user

git clone https://github.com/gofer/docker-php-fpm

cd /home/ec2-user/docker-php-fpm

if [ -f requirements.txt ]; then
  pip3 install -t vendor -r requirements.txt
fi
