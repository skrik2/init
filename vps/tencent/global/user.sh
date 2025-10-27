#!/bin/bash

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
        # 使用 wget 下载文件
        wget -O "$output" "$url"
        
        # 如果下载成功且文件非空，退出循环
        if check_file; then
            echo "file: $output download success!"
            break
        else
            echo "faild download or file is empty, and trying download again..."
            # 如果文件存在，尝试删除
            if [ -f "$output" ]; then
                rm "$output"
            fi
            sleep 2  # 暂停 2 秒后再试
        fi
    done
}

download_file_hash() {
    local url="$1"
    local output="$2"
    local expected_sha256="$3"
    
    # 检测文件是否存在且非空
    check_file() {
        if [ -s "$output" ]; then
            return 0  # 文件存在且非空
        else
            return 1  # 文件不存在或为空
        fi
    }

    check_sha256() {
        local actual_sha256
        actual_sha256=$(sha256sum "$output" | awk '{ print $1 }')  # 获取纯 hash 值
        if [ "$actual_sha256" == "$expected_sha256" ]; then
            return 0  # SHA-256 匹配
        else
            echo "Actual sha256: $actual_sha256"
            echo "Expected sha256: $expected_sha256"
            return 1  # SHA-256 不匹配
        fi
    }

    # 尝试下载，直到文件存在且非空
    while true; do
        # 使用 wget 下载文件
        wget -O "$output" "$url"
        sleep 15
        
        # 如果下载成功且文件非空，退出循环
        echo "Verifying file..."
        if check_file && check_sha256; then
            echo "file: $output download success!"
            break
        else
            echo "faild download or file is empty, and trying download again..."
            # 如果文件存在，尝试删除
            if [ -f "$output" ]; then
                rm "$output"
            fi
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

# go 1.24.2
download_file_hash "https://go.dev/dl/go1.24.2.linux-amd64.tar.gz" "go1.24.2.linux-amd64.tar.gz" "68097bd680839cbc9d464a0edce4f7c333975e27a90246890e9f1078c7e702ad"

# =========================== Install =========================================== #

# go 1.24.2
sudo tar -C /usr/local -xzf go1.24.2.linux-amd64.tar.gz
