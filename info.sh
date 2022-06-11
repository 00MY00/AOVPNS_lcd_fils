#!/bin/bash
VPN_server_info()
{
cd /home/Chang_my/lcd
sudo chmod +rwx *
sudo rm -f VPN_server_info.py
ssh_info=$(service ssh status | grep Active)
ssh_info=${ssh_info:12:7}
ssh_info=$(echo "$ssh_info" | tr " " "-")
if [ "$ssh_info" = "-active" ];
then
	sudo echo -e "SSH=\"ON\"" >> VPN_server_info.py
else
	sudo echo -e "SSH=\"OFF\"" >> VPN_server_info.py
fi

vpn_info=$(service ssh status | grep Active)
vpn_info=${vpn_info_info:12:7}
vpn_info=$(echo "$vpn_info" | tr " " "-")
if [ "$vpn_info" = "-active" ];
then
	sudo echo -e "VPN=\"ON\"" >> VPN_server_info.py
	
else
	sudo echo -e "VPN=\"OFF\"" >> VPN_server_info.py

fi

i=0
user_info=$(users)
y=$(echo "$user_info" | tr " " "\n")
for user_find in $y; 
do 
i=$(( $i + 1 ))
done
sudo echo -e "user=\"$user_info\"" >> VPN_server_info.py
sudo echo -e "nb_user=\"$i\"" >> VPN_server_info.py

sudo sed -i "s/root//" "VPN_server_info.py"


date=$(date)
sudo echo -e "date=\"$date\"" >> VPN_server_info.py



}

VPN_server_info
sleep 1
python3 AOVPNS_lcd.py
