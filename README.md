# CentOS
#SetManyIPplus 用于单网卡CentOS服务器一键占群
#使用命令如下:
yum update && yum -y install git
git clone https://github.com/znkbqn1/CentOS.git
cd ./CentOS &&  chmod +x SetManyIPplus && ./SetManyIPplus
#SetManyIPplus 使用引导：
#本脚本先执行静态（主）IP设置，完成后通过for循环批量添加IP集群，且主IP包含在占群IP内
#IP格式：A.B.C.D
read -p "请输入设置IP段(A.A):" IP                  A.B         (主IP A.B)
read -p "请输入IP第三位起始位(A):" SIP               C          (主IP .C.)
read -p "请输入IP第三位结束位(A):" EIP               C
read -p "请输入设置（主）IP尾号(1~255):" SetIP       D           (主IP .D)
read -p "请输入批量IP起始位(1~255):" StartIP        D
read -p "请输入批量IP结束位(1~255):" EndIP          D
#主IP是包含在占群IP内
#主IP是包含在占群IP内
#主IP是包含在占群IP内
