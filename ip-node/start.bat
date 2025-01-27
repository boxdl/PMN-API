@echo off
REM 检查是否安装了 Python 3.8.10
for /f "tokens=*" %%P in ('where python') do (
    %%P --version 2>nul | findstr "3.8.10" >nul
    IF %ERRORLEVEL% EQU 0 (
        echo Python 3.8.10 已安装
        goto RUN_SCRIPT
    )
)

REM 如果没有安装 Python 3.8.10，则下载安装
echo Python 3.8.10 未安装，正在下载安装...
set "url=https://www.python.org/ftp/python/3.8.10/python-3.8.10.exe"
set "file=python-3.8.10.exe"
powershell -Command "Invoke-WebRequest -Uri %url% -OutFile %file%"
start /wait %file% /quiet InstallAllUsers=1 PrependPath=1
echo Python 3.8.10 安装完成

:RUN_SCRIPT
REM 使用 Python 3.8 启动指定文件
echo 正在启动指定文件...
python main.pyc

REM 如果文件被多次启动，自动重启
:RESTART
IF %ERRORLEVEL% NEQ 0 (
    echo 文件启动失败，正在重新启动...
    python main.pyc
    GOTO RESTART
)
