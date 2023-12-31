#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "เกิดข้อผิดพลาด: กรุณาเข้าสู่ระบบด้วย root : sudo -i ก่อนลงสคริปต์" 2>&1
  exit 1
fi

NC='\033[0m'
MYIP=$(wget -qO- http://whatismyip.akamai.com/)

apt update
apt -y install gpg curl gnupg2 wget unzip software-properties-common apt-transport-https lsb-release ca-certificates
apt -y install neofetch
echo "clear" >> .bash_profile
echo "neofetch" >> .bash_profile

echo "deb https://repo.mongodb.org/apt/debian buster/mongodb-org/6.0 main" > /etc/apt/sources.list.d/mongodb-org-6.0.list
echo "deb https://repo.pritunl.com/stable/apt buster main" > /etc/apt/sources.list.d/pritunl.list
sudo apt --assume-yes install gnupg
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg \--dearmor
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 6A26B1AE64C3C388
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 7AE645C0CF8E292A
apt update
apt --assume-yes install pritunl mongodb-org
systemctl start pritunl mongodb
systemctl enable pritunl mongodb

clear

cd

apt update
apt -y install squid

cp /etc/squid/squid.conf /etc/squid/squid.conf.orig
echo "acl localnet src 0.0.0.1-0.255.255.255  # RFC 1122 "this" network (LAN)
acl localnet src 10.0.0.0/8             # RFC 1918 local private network (LAN)
acl localnet src 100.64.0.0/10          # RFC 6598 shared address space (CGN)
acl localnet src 169.254.0.0/16         # RFC 3927 link-local (directly plugged>
acl localnet src 172.16.0.0/12          # RFC 1918 local private network (LAN)
acl localnet src 192.168.0.0/16         # RFC 1918 local private network (LAN)
acl localnet src fc00::/7               # RFC 4193 local private network range
acl localnet src fe80::/10              # RFC 4291 link-local (directly plugged>

acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http
acl CONNECT method CONNECT

acl ip_server dst $MYIP-$MYIP/255.255.255.255

http_access allow ip_server
http_access allow localhost manager
http_access deny manager
http_access allow localnet
http_access allow localhost
http_access deny all

http_port 8080

cache_store_log none
cache_log /dev/null
logfile_rotate 0

via off
forwarded_for off
dns_v4_first on
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern \/(Packages|Sources)(|\.bz2|\.gz|\.xz)$ 0 0% 0 refresh-ims
refresh_pattern \/Release(|\.gpg)$ 0 0% 0 refresh-ims
refresh_pattern \/InRelease$ 0 0% 0 refresh-ims
refresh_pattern \/(Translation-.*)(|\.bz2|\.gz|\.xz)$ 0 0% 0 refresh-ims
refresh_pattern .               0       20%     4320
visible_hostname Phanudet" > /etc/squid/squid.conf

/etc/init.d/squid start
/etc/init.d/squid restart

clear
sudo apt update

sudo ufw allow ssh
sudo ufw allow 8080

clear
cd
cd /usr/bin
wget -O /usr/local/bin/00 "https://raw.githubusercontent.com/lemon-zaza/Alone/master/guzaa"
wget -O /usr/local/bin/01 "https://raw.githubusercontent.com/lemon-zaza/Alone/master/edit2"
wget -O /usr/local/bin/02 "https://raw.githubusercontent.com/lemon-zaza/Alone/master/ReU20"
wget -O /usr/local/bin/03 "https://raw.githubusercontent.com/lemon-zaza/Alone/master/ufw"

chmod +x /usr/local/bin/00
chmod +x /usr/local/bin/01
chmod +x /usr/local/bin/02
chmod +x /usr/local/bin/03
cd

clear
echo -e ""
echo -e "\E[44;1;45m          ------ • ≧ ติดตั้งสำเร็จ..! ≦ • ------           \E[0m"
echo -e "\033[1;32m*\033[1;33m ความคุมเซิร์ฟเวอร์ด้วยระบบ \033[1;32mPRITUNL."
echo -e "\033[1;32m*\033[1;37mMENU \033[1;31m:\033[1;32m 00"
echo -e ""
echo -e "\033[1;32m• \033[1;37mTimezone \033[1;31m: \033[1;32m Thailand"
echo -e "\033[1;32m• \033[1;37mSquid Proxy \033[1;31m: \033[1;32m$MYIP"
echo -e "\033[1;32m• \033[1;37mProxy Port  \033[1;31m: \033[1;32m8080"
echo -e "\033[1;32m• \033[1;36mPritunl Websites https://$MYIP${NC}"
echo -e ""
pritunl setup-key
echo -e ""
echo -e "\033[1;32mCopy key Go to website"
echo -e ""
echo -ne " \033[1;33m?\033[1;37m${NC} "
