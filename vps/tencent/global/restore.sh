#!/bin/bash

mkdir .ssh 
mkdir .config

# config 
cd config_file

## .config/neovim
rsync -rv .config /home/momo/

## ssh
sudo mv global.conf /etc/ssh/sshd_config.d/
rsync -rv .ssh /home/momo/

sudo systemctl restart sshd

## zsh
mv .zshrc /home/momo/
mv .zsh_envs /home/momo/
mv .zsh_aliases /home/momo/



## git
mv .gitconfig /home/momo/

cd ~

cd backup

# apps file dev
rsync -rv apps /home/momo/
rsync -rv file /home/momo/
rsync -rv code /home/momo/