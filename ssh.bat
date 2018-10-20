:batset
@echo off
color f0
title ������Զ�̹�����ƹ���
echo.
@rem �����ã�
set conffile=servercfg.txt
set keyfile=./key/key.txt
echo ��ǰ�����ļ���%conffile%
echo ��ǰ��Կ�ļ���%keyfile%
echo.
goto :sethost

:sethost
title ������Զ�̹�����ƹ���
echo �������������Ϣ
set server=
set user=root
set port=22
set /p server="set hostname:"
set /p port="set port(22):"
set /p user="set user(root):"
echo д����ʱ�����ļ� %conffile%
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
echo  ServerCtl.exe ������Զ�̹�����ƹ���V1.5
echo  ����iDrac6/7/8/9
echo  a@ghzgqx.com 2018.10
echo.
echo  help - ����
echo.

:mainmenu
color f0
title ������Զ�̹�����ƹ��� - ���˵�
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
echo  status - ��Դ״̬
echo  start - ����
echo  stop - �ػ�
echo  shutdown - ǿ�ƶϵ�
echo  connect - COM2�ض���(BIOS/UEFI���� ������˳�� COM���ն�)
echo  racadm - racadmָ���
echo  killall - �Ͽ����лỰ
echo  smclp - IPMI�ն�(SMCLP)
echo  hostname - �л�������
echo  clear - ����
echo  exit - �˳�
goto :mainmenu

:powerstatus
title ��ѯ��Դ״̬ - �������ӷ�����
ssh.exe -F %conffile% default racadm serveraction powerstatus
echo ��ѯ��Դ״̬ - ���
goto :mainmenu


:powerup
title ���� - �������ӷ�����
ssh.exe -F %conffile% default racadm serveraction powerup
echo ���� - ���
goto :mainmenu

:powerdown
title �ػ� - �������ӷ�����
ssh.exe -F %conffile% default racadm serveraction powerdown
echo �ػ� - ���
goto :mainmenu

:graceshutdown
title ǿ�ƶϵ� - �������ӷ�����
ssh.exe -F %conffile% default racadm serveraction graceshutdown
echo ǿ�ƶϵ� - ���
goto :mainmenu

:connect
title COM2����̨ - ��CTRL + \ �˳�
color 07
cls
ssh.exe -F %conffile% -t default connect
echo �ѶϿ�
title COM2����̨ - �ѶϿ�
echo ��������������˵�...
pause>nul 2>nul
goto :start

:racadm
title ������Զ�̹����߿���̨ ����exit�˳�
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
title �������ӷ�����...
ssh.exe -F %conffile% default racadm %sendcommand%
echo ִ����� ����
set sendcommand=
goto :racadm

:killall
title �ر����лỰ - �������ӷ�����
ssh.exe -F %conffile% default racadm closessn -a
echo �ر����лỰ - ���
goto :mainmenu


:ipmiconsole
title IPMI�նˣ�SMCLP��
color 07
cls
ssh.exe -F %conffile% -t default
echo �ն��ѶϿ�
echo ��������������˵�...
pause>nul 2>nul
goto :start

:error
echo serverctl: %select% �������
goto :mainmenu

:quit
echo.
echo ��л����ʹ�ã���������˳�����...
pause>nul 2>nul
exit



