#!/bin/bash
mkdir -p backup/config_file

# config 
## zsh
cp .zshrc /home/momo/backup/config_file/
cp .zsh_envs /home/momo/backup/config_file/
cp .zsh_aliases /home/momo/backup/config_file/

# ssh
rsync -rv /home/momo/.ssh /home/momo/backup/config_file/ 
cp /etc/ssh/sshd_config.d/global.conf /home/momo/backup/config_file/

## neovim
rsync -rv /home/momo/.config /home/momo/backup/config_file/

## git
cp .gitconfig /home/momo/backup/config_file/

# apps file dev
sudo rsync -rv apps /home/momo/backup/
rsync -rv file /home/momo/backup/ 
sudo rsync -rv dev /home/momo/backup/ 

mkdir temp
mv backup temp && cd temp

timestamp=$(date "+%Y%m%d%H%M")
filename="backup_${timestamp}.zip"
zip -s 256m -r ${filename} backup

rm -rf backup
