#!/bin/sh

set -xe

yum update && yum upgrade

yum install -y git docker tmux

systemctl enable docker && systemctl start docker

usermod -aG docker ec2-user
