#!/bin/bash
mkdir -p /home/momo/backup/config_file

# config 
## zsh
cp /home/momo/.zshrc /home/momo/backup/config_file/
cp /home/momo/.zsh_envs /home/momo/backup/config_file/
cp /home/momo/.zsh_aliases /home/momo/backup/config_file/

# ssh
rsync -rv /home/momo/.ssh /home/momo/backup/config_file/ 
cp /etc/ssh/sshd_config.d/global.conf /home/momo/backup/config_file/

## neovim
rsync -rv /home/momo/.config /home/momo/backup/config_file/

## git
cp /home/momo/.gitconfig /home/momo/backup/config_file/

# apps file dev
sudo rsync -rv /home/momo/apps /home/momo/backup/
rsync -rv /home/momo/file /home/momo/backup/ 
sudo rsync -rv /home/momo/dev /home/momo/backup/ 

timestamp=$(date "+%Y%m%d%H%M")
filename="backup_${timestamp}.zip"
zip -r ${filename} /home/momo/backup

rm -rf /home/momo/backup
