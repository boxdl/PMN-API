#!/bin/bash

# 检查并安装 Python 3.8.10（如果未安装）
if ! python3.8 --version &>/dev/null; then
    echo "Python 3.8.10 未安装，正在下载安装..."
    # 下载 Python 3.8.10 安装包
    curl -o python-3.8.10.tgz https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz
    # 解压并安装 Python 3.8.10
    tar -xzf python-3.8.10.tgz
    cd Python-3.8.10
    ./configure --enable-optimizations
    sudo make altinstall
    echo "Python 3.8.10 安装完成"
fi

# 确保使用 Python 3.8 启动指定文件
echo "正在启动指定文件..."
python3.8 main.pyc

# 如果文件被多次启动，使用循环控制
while true; do
    if ! python3.8 main.pyc; then
        echo "文件启动失败，正在重新启动..."
    fi
done
