#!/bin/bash

lcd()
{
back=$(pwd)
while ((i<1));									# Conection des pins
do
	clear
	echo -e "################################################################"
	echo -e "Conection pour écrant LCD"
	echo -e "Prérequis:"
	echo -e "		Joy-it SBC-LCD16x2 Display-Modul 6.6 cm"
	echo -e "		LCDZ IIC-I2C"
	echo -e "		Cable Mâle-femmelle X4"
	echo -e "		Cable Mâle-Mâle	    X4\n"
	echo -e "	---------------------------------------"
	echo -e "Les branchements:"
	echo -e "0)	Brancher le module LCDZ IIC-I2C dans les pines de l'écrant LCD"
	echo -e "1)	pin GND SBC-LCD sur pin GND rasspberry"
	echo -e "2)	pin VCC SBC-LCD sur pin 5V rasspberry"
	echo -e "3)	pin SDA SBC-LCD sur pin SDA1 rasspberry"
	echo -e "4)	pin SCL SBC-LCD sur pin SCL1 rasspberry"
	echo -e "################################################################"
	echo -e "\nEntrez [ confirme ] pour confirmer que vos branchements son juste\n"

read -p ": " fini_conection

if [ "$fini_conection" = "confirme" ];
then
	break
	
fi

done

while ((i<1));
do
	clear 
	echo -e "#########################################"
	echo -e "\n"
	echo -e "Entrez le nom de la Time Zone"
	echo -e "Entrez ? pour les afficher tous"
	echo -e "Raccourcis"
	echo -e "[ ch ] pour Zurich [ fr ] pour Paris"
	echo -e "#########################################"
	echo -e "\n\n"
	
	read -p ": " NomdelaTimeZone
	
	if [ "$NomdelaTimeZone" = "?" ];
	then
		echo -e "Entrez [ q ] pour fermer"
		timedatectl list-timezones
	
	elif [ "$NomdelaTimeZone" = "ch" ];
	then
		NomdelaTimeZone=Europe/Zurich
		sudo timedatectl set-timezone $NomdelaTimeZone
		if [ "$?" -eq "0" ]
		then
			echo -e "\033[32m[OK]\033[00m terminer"
			sleep 2
			break
		else
			echo -e "\033[31mERREUR !\033[00m"
			sleep 2
		fi

	elif [ "$NomdelaTimeZone" = "fr" ];
	then
		NomdelaTimeZone=Europe/Paris
		sudo timedatectl set-timezone $NomdelaTimeZone
		if [ "$?" -eq "0" ]
		then
			echo -e "\033[32m[OK]\033[00m terminer"
			sleep 2
			break
		else
			echo -e "\033[31mERREUR !\033[00m"
			sleep 2
		fi

	else
		sudo timedatectl set-timezone $NomdelaTimeZone
		if [ "$?" -eq "0" ]
		then
			echo -e "\033[32m[OK]\033[00m terminer"
			sleep 2
			break
		else
			echo -e "\033[31mERREUR !\033[00m"
			sleep 2
		fi
	fi
done

# HEur est date

# timedatectl list-timezones

# sudo timedatectl set-timezone Europe/Paris


# Installation resource

sudo apt install python3-dev python3-rpi.gpio -y
sudo apt-get install python3-smbus python3-dev i2c-tools



if [ "$?" -eq "130" ];				# Corection ci erreur double procesuse 
then
	x=$(ps aux | grep -i dpkg)
	y=' ' read -ra z <<< "$x"
	service=$(echo ${z[1]})
	sudo kill $service
fi
sudo git clone https://github.com/the-raspberry-pi-guy/lcd.git
cd ./lcd/
sudo rm -f demo_*.py

#---------------------
# affichage sur LCD
sudo wget https://raw.githubusercontent.com/00MY00/AOVPNS_lcd_fils/main/AOVPNS_lcd.py
# recherche donner pour l'affichage
sudo wget https://raw.githubusercontent.com/00MY00/AOVPNS_lcd_fils/main/info.sh
# pour la tache planifier
sudo wget https://raw.githubusercontent.com/00MY00/AOVPNS_lcd_fils/main/LCD_tach.service
#---------------------

#---------------------
sudo chmod +rwx *.*
#---------------------
sudo sed -i "s/USER/$USER/" "LCD_tach.service"			# ajoute le nom de l'utilisateur
sudo sed -i "s/Chang_my/$USER/" "info.sh"				# ajoute le nom de l'utilisateur
sudo mv LCD_tach.service /etc/systemd/system/			# déplace dans le bon répertoire
sudo chmod +rwx /etc/systemd/system/LCD_tach.service	# donne les drois
sudo systemctl enable  LCD_tach.service					# acctive la tache
# Verrifie bonne localisation des fichier
[ ! -d "/home/$USER/lcd" ] && sudo mkdir /home/$USER/lcd
[ ! -f "/home/$USER/lcd/info.sh" ] && sudo mv info.sh /home/$USER/lcd
[ ! -f "/home/$USER/lcd/AOVPNS_lcd.py" ] && sudo mv AOVPNS_lcd.py /home/$USER/lcd
[ ! -d "/home/$USER/lcd/configs" ] && sudo mv configs /home/$USER/lcd
[ ! -d "/home/$USER/lcd/drivers" ] && sudo mv drivers /home/$USER/lcd
sudo chmod 777 * /home/$USER/lcd
sudo chmod 777 /home/$USER/lcd/VPN_server_info.py
#---------------------

sudo rm -f install.sh
sudo chmod +rwx setup.sh
sudo ./setup.sh




}

lcd 					# Appel de la fonction LCD