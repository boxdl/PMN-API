#!/bin/bash

# 检查是否安装了 Python 3.8.10
if python3.8 --version 2>/dev/null | grep -q "3.8.10"; then
    echo "Python 3.8.10 已安装"
else
    echo "Python 3.8.10 未安装，正在下载安装..."
    curl -o python-3.8.10.tgz https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz
    tar -xzf python-3.8.10.tgz
    cd Python-3.8.10
    ./configure --enable-optimizations
    sudo make altinstall
    cd ..
    echo "Python 3.8.10 安装完成"
fi

# 确保安装 pip
echo "正在确保 pip 已安装..."
python3.8 -m ensurepip --upgrade
python3.8 -m pip install --upgrade pip

# 安装所需库
echo "正在安装所需库..."
python3.8 -m pip install flask requests

# 启动 main.pyc 文件
echo "正在启动 main.pyc 文件..."
python3.8 main.pyc

# 如果文件被多次启动，自动重启
while true; do
    if ! python3.8 main.pyc; then
        echo "程序崩溃，正在重新启动..."
    fi
done
