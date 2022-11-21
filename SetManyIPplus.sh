#!/bin/bash
#该脚本用于设置网卡的IP地址
#第一部分：变量的设置
echo "默认子网掩码24、默认网关 .1、默认DNS1 8.8.8.8 DNS2 114.114.114.114"
ETH=$(ifconfig | grep '^eth' | awk -F ":" '{print$1}')
MAC=$(ifconfig | grep "^eth" | awk  '{print$5}')
read -p "请输入设置IP段(A.A):" IP
read -p "请输入IP第三位起始位(A):" SIP
read -p "请输入IP第三位结束位(A):" EIP
read -p "请输入设置（主）IP尾号(1~255):" SetIP
read -p "请输入批量IP起始位(1~255):" StartIP
read -p "请输入批量IP结束位(1~255):" EndIP

#第二部分:备份网卡配置文件
echo "正在备份网卡配置文件"
\cp /etc/sysconfig/network-scripts/ifcfg-$ETH{,.bak}
echo "完成备份"

#第三部分:写入到配置文件
echo 'DEVICE='$ETH'
HWADDR='$MAC'
TYPE='Ethernet'
BOOTPROTO='static'
IPADDR='$IP'.'$SIP'.'$SetIP'
GATEWAY='$IP'.'$SIP'.1
NETMASK=255.255.255.0
DNS1=8.8.8.8
DNS2=114.114.114.114' >/etc/sysconfig/network-scripts/ifcfg-$ETH

#第四部:启动服务
echo "ifdown 关闭网卡"
ifdown $ETH
echo "ifup 开启网卡"
ifup $ETH
echo "service"
service network restart
echo "systemctl"
systemctl restart network
echo "nmcli"
nmcli c up $ETH

#第五部分:批量IP
echo "批量IP"
#单循环批量IP
#for i in `seq $StartIP $EndIP`; do nmcli c mod /etc/sysconfig/network-scripts/ifcfg-eth0 ipv4.method manual +ipv4.addr "$IP.${i}/24"; done
for e in `seq $SIP $EIP`;do for i in `seq $StartIP $EndIP`; do nmcli c mod /etc/sysconfig/network-scripts/ifcfg-eth0 ipv4.method manual +ipv4.addr "$IP.${e}.${i}/24"; done ;done

#第六部分:再次启动服务
echo "ifdown 关闭网卡"
ifdown $ETH
echo "ifup 开启网卡"
ifup $ETH
echo "service"
service network restart
echo "systemctl"
systemctl restart network
echo "nmcli"
nmcli c up $ETH