#!/bin/sh
apt-get update && apt-get install git wget curl -y

curl -O https://yanghao5.github.io/init/vps/tencent/global/root.sh
curl -O https://yanghao5.github.io/init/vps/tencent/global/restore.sh
curl -O https://yanghao5.github.io/init/vps/tencent/global/user.sh

curl -o get-docker.sh https://get.docker.com 

# ohmyzsh
curl -o ohmyzsh_install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

# nvm
curl -o nvm_install.sh https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh

# Cmake 3.28.2
curl -O https://github.com/Kitware/CMake/releases/download/v3.28.2/cmake-3.28.2-linux-x86_64.tar.gz

# LLVM 
curl -O https://apt.llvm.org/llvm.sh

# Golang 1.24.2
curl -O https://go.dev/dl/go1.24.2.linux-amd64.tar.gz

# 获取当前目录下文件的数量（不包含子目录）
file_count=$(find . -maxdepth 1 -type f | wc -l)

# 判断文件数量是否等于 9
if [ "$file_count" -ne 9 ]; then
  echo "错误：当前目录中文件数量不是 9，而是 $file_count"
  exit 1
else
  echo "文件数量正确：$file_count"
fi
