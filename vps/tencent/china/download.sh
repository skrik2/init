#!/bin/sh
REMOTE=${REMOTE:-https://gh-proxy.com/}

# script
wget ${REMOTE}https://raw.githubusercontent.com/yanghao5/vps-init/refs/heads/main/tencent/china/restore.sh
wget ${REMOTE}https://raw.githubusercontent.com/yanghao5/vps-init/refs/heads/main/tencent/china/user.sh

# nvm
git clone --bare --depth=1 ${REMOTE}https://github.com/nvm-sh/nvm.git

# ohmyzsh
wget ${REMOTE}https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O ohmyzsh_install.sh
git clone --bare --depth=1 ${REMOTE}https://github.com/ohmyzsh/ohmyzsh.git

# Golang 1.26.4
wget https://go.dev/dl/go1.26.4.linux-amd64.tar.gz
