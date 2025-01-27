@echo off
REM 检查并安装 Python 3.8.10（如果未安装）
python --version 2>nul | findstr /i "Python 3.8.10" >nul
IF %ERRORLEVEL% NEQ 0 (
    echo Python 3.8.10 未安装，正在下载安装...
    REM 下载 Python 3.8.10 安装包
    set "url=https://www.python.org/ftp/python/3.8.10/python-3.8.10.exe"
    set "file=python-3.8.10.exe"
    REM 使用 PowerShell 下载
    powershell -Command "Invoke-WebRequest -Uri %url% -OutFile %file%"
    REM 安装 Python 3.8.10
    start /wait python-3.8.10.exe /quiet InstallAllUsers=1 PrependPath=1
    echo 安装完成
)

REM 确保使用 Python 3.8 启动指定文件
echo 正在启动指定文件...
python3.8 main.pyc

REM 如果文件被多次启动，使用循环控制
:RESTART
IF %ERRORLEVEL% NEQ 0 (
    echo 文件启动失败，正在重新启动...
    python3.8 main.pyc
    GOTO RESTART
)
