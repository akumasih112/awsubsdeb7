#!/bin/bash

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

MYIP=$(wget -qO- ipv4.icanhazip.com)

# go to root
cd


read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " fnsaktif

IP=`dig +short myip.opendns.com @resolver1.opendns.com`
useradd -e `date -d "$fnsaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "============================"
echo -e "Informasi Account SSH"
echo -e "============================"
echo -e "Host/IP: $IP" 
echo -e "Username: $Login"
echo -e "Password: $Pass"
echo -e "SSL/TLS Port : 443, 80"
echo -e "Dropbear Port: 442, 82"
echo -e "OpenSSH Port: 143, 109, 110"
echo -e "Squid Proxy: 8080, 8000"
echo -e "Config OpenVPN (TCP 1194) : http://$IP:81/client.ovpn"
echo -e "-----------------------------"
echo -e "Aktif Sampai: $exp"
echo -e "==========================="
echo -e "Script Powered By Owner SamudraSSH"


cd ~/
rm -f /root/daftarip
