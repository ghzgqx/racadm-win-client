@echo off
echo �������س�ֱ�����ڹر�
echo ��������key.txt��˽Կ����ket.txt.pub����Կ��
PAUSE
ssh-keygen -C "rsa-key" -b 2048 -t rsa -f key.txt
