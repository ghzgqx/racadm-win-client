#关于
a@ghzgqx.com <br>
idrac/racadm常用操作的windows客户端<br>
基于IDRAC SSH RACADM<br>

#说明
默认使用密钥登陆修改ssh.bat的这一行 改成所需文件名<br>
 
 ```
 set keyfile=./key/key.txt
 ```
 
启动时需要设置服务器信息<br>
IP/域名 set hostname:<br>
端口 set port(22):<br>
用户名 set user(root):<br>

命令<br>
status - 电源状态<br>
start - 开机<br>
stop - 关机<br>
shutdown - 强制断电<br>
connect - COM2重定向(BIOS/UEFI设置 启动项顺序 COM口终端)<br>
racadm - racadm指令发送<br>
killall - 断开所有会话<br>
smclp - IPMI终端(SMCLP)<br>
hostname - 切换服务器<br>
clear - 清屏<br>
exit - 退出<br>
