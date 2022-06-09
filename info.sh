#!/bin/bash
VPN_server_info()								# Recupère les information pour l'affichage LCD
{
rm -f VPN_server_info.py
ssh_info=$(service ssh status | grep Active)
ssh_info=${ssh_info:12:7}
ssh_info=$(echo "$ssh_info" | tr " " "-")
if [ "$ssh_info" = "-active" ];
then
	echo -e "SSH=\"ON\"" >> VPN_server_info.py
else
	echo -e "SSH=\"OFF\"" >> VPN_server_info.py
fi

vpn_info=$(service ssh status | grep Active)
vpn_info=${vpn_info_info:12:7}
vpn_info=$(echo "$vpn_info" | tr " " "-")
if [ "$vpn_info" = "-active" ];
then
	echo -e "VPN=\"ON\"" >> VPN_server_info.py
	
else
	echo -e "VPN=\"OFF\"" >> VPN_server_info.py

fi

i=0
user_info=$(users)
y=$(echo "$user_info" | tr " " "\n")
for user_find in $y; 
do 

echo -e "user$i=\"$user_find\"" >> VPN_server_info.py
i=$(( $i + 1 ))
done

date=$(date)
echo -e "date=\"$date\"" >> VPN_server_info.py

}
VPN_server_info
python3 AOVPNS_lcd.py