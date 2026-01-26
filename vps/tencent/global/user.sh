#!/bin/bash

#============================== download_file() =============================================#
download_file() {
    local url="$1"
    local output="$2"
    local max_retries=5
    local attempt=1
    
    # 检测文件是否存在且非空
    check_file() {
        if [ -s "$output" ]; then
            return 0  # 文件存在且非空
        else
            return 1  # 文件不存在或为空
        fi
    }

    # 尝试 5 次下载
    while [ $attempt -le $max_retries ]; do
        echo "Attempt $attempt/$max_retries: downloading $url ..."
        # 使用 wget 下载文件
        wget -O "$output" "$url"
        
        # 如果下载成功且文件非空，退出循环
        if check_file; then
            echo "file: $output download success!"
            return 0
        else
            echo "faild download or file is empty, and trying download again..."
            # 如果文件存在，尝试删除
            if [ -f "$output" ]; then
                rm -f "$output"
            fi
            attempt=$((attempt + 1))
            sleep 2  # 暂停 2 秒后再试
        fi
    done
    echo "ERROR: failed to download $url after $max_retries attempts."
    return 1
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

# restore.sh
download_file "https://skrik2.github.io/init/vps/tencent/global/restore.sh" "restore.sh"
chmod +x restore.sh

# go 1.25.6
download_file_hash "https://go.dev/dl/go1.25.6.linux-amd64.tar.gz" "go1.25.6.linux-amd64.tar.gz" "f022b6aad78e362bcba9b0b94d09ad58c5a70c6ba3b7582905fababf5fe0181a"

# =========================== Install =========================================== #

# go 1.25.6
sudo tar -C /usr/local -xzf go1.25.6.linux-amd64.tar.gz
