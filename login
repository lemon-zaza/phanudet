#!/bin/bash

MYIP=$(wget -qO- http://whatismyip.akamai.com/)

NC='\033[0m'
wget -O /etc/ssh/sshd_config 'https://raw.githubusercontent.com/lemon-zaza/phanudet/master/sshdd'
/etc/init.d/ssh restart

echo -e ""
echo -e "\033[1;37m **\033[1;31m SET LOGIN ROOT \033[1;37m **${NC}"
echo -e ""
echo -e "\033[1;32m •ชื่อผู้ใช้ \033[1;37m root@$MYIP \033[1;31m Password \033[1;37m ???..${NC}"
echo -e "\033[1;32m •\033[1;33m ใส่ซื่อผู้ใช้เดิม หรือ ตั้งใหม่ \033[1;37m ? ${NC}"
echo -e ""
passwd root
/etc/init.d/ssh restart
echo -e ""
echo -e "\033[1;32m OK...${NC}"
echo -e ""
echo -e "\033[1;37m เข้าสู่ระบบด้วย root และรหัสใหม่.....${NC}"
echo -e ""
