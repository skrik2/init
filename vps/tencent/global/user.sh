#!/bin/sh

# ========================================== download ============================================= #
download_file() {
    local url="$1"
    local output="$2"
    
    # 检测文件是否存在且非空
    check_file() {
        if [ -s "$output" ]; then
            return 0  # 文件存在且非空
        else
            return 1  # 文件不存在或为空
        fi
    }

    # 尝试下载，直到文件存在且非空
    while true; do
        # 使用 curl 下载文件
        curl -o "$output" "$url"
        
        # 如果下载成功且文件非空，退出循环
        if check_file; then
            echo "file: $output download succe！"
            break
        else
            echo "文件下载失败或为空，正在重新尝试..."
            sleep 2  # 暂停 2 秒后再试
        fi
    done
}

#ohmyzsh
download_file "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" "ohmyzsh_install.sh"
chmod +x ohmyzsh_install.sh

# nvm
download_file "https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh" "nvm_install.sh"
chmod +x nvm_install.sh

# Golang 1.24.2
download_file "https://go.dev/dl/go1.24.2.linux-amd64.tar.gz" "go1.24.2.linux-amd64.tar.gz"

# =========================== Install =========================================== #

# go 1.24.2
# sudo tar -C /usr/local -xzf go1.24.2.linux-amd64.tar.gz


