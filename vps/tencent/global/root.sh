#!/bin/bash

# 脚本开始时检查是否有 root 权限
if [ "$(id -u)" -ne 0 ]; then
  echo "请使用 root 权限运行此脚本"
  exit 1
fi

# swap mem 4G
sudo dd if=/dev/zero of=/swapfile bs=128M count=32
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
sysctl vm.swappiness=90

# init
apt-get update && apt-get install git wget curl -y

# install 
apt-get update && apt-get install sudo wget curl neovim git btop zsh rsync jq -y

# add user momo proxy jumper
adduser --disabled-password --gecos "" momo
adduser --disabled-password --gecos "" lain
adduser --disabled-password --gecos "" jumper

# 给 root 权限
usermod -aG sudo momo
echo "%sudo   ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers

# set passwd
echo "root:op" | chpasswd
echo "momo:op" | chpasswd

# Docker
curl -o get-docker.sh https://get.docker.com 
sh ./get-docker.sh

## 给 momo 用户执行 docker 权限
usermod -aG docker momo