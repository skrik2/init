#!/bin/bash

mkdir .ssh

cd backup

# apps file dev
rsync -rv apps /home/momo/
rsync -rv file /home/momo/
rsync -rv dev /home/momo/

# config 
cd config_file

## .config/neovim
rsync -rv .config /home/momo/

## ssh
sudo mv global.conf /etc/ssh/sshd_config.d/
rsync -rv .ssh /home/momo/

## zsh
mv .zshrc /home/momo/
mv .zsh_envs /home/momo/
mv .zsh_aliases /home/momo/


## git
mv .gitconfig /home/momo/


