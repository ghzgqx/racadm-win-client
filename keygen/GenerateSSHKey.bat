@echo off
echo 请连按回车直到窗口关闭
echo 将会生成key.txt（私钥）和ket.txt.pub（公钥）
PAUSE
ssh-keygen -C "rsa-key" -b 2048 -t rsa -f key.txt
