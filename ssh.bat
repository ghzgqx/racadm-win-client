:batset
@echo off
color f0
title 服务器远程管理控制工具
echo.
@rem 主设置：
set conffile=servercfg.txt
set keyfile=./key/key.txt
echo 当前配置文件：%conffile%
echo 当前密钥文件：%keyfile%
echo.
goto :sethost

:sethost
title 服务器远程管理控制工具
echo 请输入服务器信息
set server=
set user=root
set port=22
set /p server="set hostname:"
set /p port="set port(22):"
set /p user="set user(root):"
echo 写入临时配置文件 %conffile%
echo Host default > %conffile%
echo HostName %server% >> %conffile%
echo User %user% >> %conffile%
echo Port %port% >> %conffile%
echo PubkeyAuthentication yes >> %conffile%
echo IdentityFile=%keyfile% >> %conffile%
echo UserKnownHostsFile=./known_hosts  >> %conffile%
echo StrictHostKeyChecking=no >> %conffile%
goto:start


:start 
cls
echo.
echo  Hostname [%user%@%server%:%port%] Cfgfile [%conffile%]
echo.
echo  ServerCtl.exe 服务器远程管理控制工具V1.5
echo  用于iDrac6/7/8/9
echo  a@ghzgqx.com 2018.10
echo.
echo  help - 帮助
echo.

:mainmenu
color f0
title 服务器远程管理控制工具 - 主菜单
set select=
set /p select="serverctl>"
if "%select%" == "" (goto :mainmenu) else (
if "%select%" == "status" (goto :powerstatus) else (
if "%select%" == "start" (goto :powerup) else (
if "%select%" == "stop" (goto :powerdown) else (
if "%select%" == "shutdown" (goto :graceshutdown) else (
if "%select%" == "connect" (goto :connect) else (
if "%select%" == "racadm" (goto :racadm) else (
if "%select%" == "smclp" (goto :ipmiconsole) else (
if "%select%" == "exit" (goto :quit) else (
if "%select%" == "clear" (goto :start) else (
if "%select%" == "killall" (goto :killall) else (
if "%select%" == "help" (goto :help) else (
if "%select%" == "hostname" (goto :sethost) else (goto :error)))))))))))))


:help
echo.
echo  ----[commands]----
echo  status - 电源状态
echo  start - 开机
echo  stop - 关机
echo  shutdown - 强制断电
echo  connect - COM2重定向(BIOS/UEFI设置 启动项顺序 COM口终端)
echo  racadm - racadm指令发送
echo  killall - 断开所有会话
echo  smclp - IPMI终端(SMCLP)
echo  hostname - 切换服务器
echo  clear - 清屏
echo  exit - 退出
goto :mainmenu

:powerstatus
title 查询电源状态 - 正在连接服务器
ssh.exe -F %conffile% default racadm serveraction powerstatus
echo 查询电源状态 - 完成
goto :mainmenu


:powerup
title 开机 - 正在连接服务器
ssh.exe -F %conffile% default racadm serveraction powerup
echo 开机 - 完成
goto :mainmenu

:powerdown
title 关机 - 正在连接服务器
ssh.exe -F %conffile% default racadm serveraction powerdown
echo 关机 - 完成
goto :mainmenu

:graceshutdown
title 强制断电 - 正在连接服务器
ssh.exe -F %conffile% default racadm serveraction graceshutdown
echo 强制断电 - 完成
goto :mainmenu

:connect
title COM2控制台 - 按CTRL + \ 退出
color 07
cls
ssh.exe -F %conffile% -t default connect
echo 已断开
title COM2控制台 - 已断开
echo 按任意键返回主菜单...
pause>nul 2>nul
goto :start

:racadm
title 服务器远程管理工具控制台 输入exit退出
set sendcommand=
set /p sendcommand="racadm>"
if "%sendcommand%" == "exit" (goto :mainmenu) else (
if "%sendcommand%" == "" (goto :racadm) else (
if "%sendcommand%" == "clear" (goto :racadmcls) else (
goto :sendcmd)))

:racadmcls
cls
goto :racadm

:sendcmd
title 正在连接服务器...
ssh.exe -F %conffile% default racadm %sendcommand%
echo 执行完成 返回
set sendcommand=
goto :racadm

:killall
title 关闭所有会话 - 正在连接服务器
ssh.exe -F %conffile% default racadm closessn -a
echo 关闭所有会话 - 完成
goto :mainmenu


:ipmiconsole
title IPMI终端（SMCLP）
color 07
cls
ssh.exe -F %conffile% -t default
echo 终端已断开
echo 按任意键返回主菜单...
pause>nul 2>nul
goto :start

:error
echo serverctl: %select% 命令不存在
goto :mainmenu

:quit
echo.
echo 感谢您的使用，按任意键退出程序...
pause>nul 2>nul
exit



