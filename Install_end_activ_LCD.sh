#!/bin/bash

lcd()
{
while ((i<1));									# Conection des pins
do
	clear
	echo -e "################################################################"
	echo -e "Conection pour écrant LCD"
	echo -e "Prérequi:"
	echo -e "		Joy-it SBC-LCD16x2 Display-Modul 6.6 cm"
	echo -e "		LCDZ IIC-I2C"
	echo -e "		Cable Mâle-femmelle X4"
	echo -e "		Cable Mâle-Mâle	    X4\n"
	echo -e "	---------------------------------------"
	echo -e "Les branchement:"
	echo -e "0)	Brancher le module LCDZ IIC-I2C dans les pine de l'écrant LCD"
	echo -e "1)	pin GND SBC-LCD sur pin GND rasspberry"
	echo -e "2)	pin VCC SBC-LCD sur pin 5V rasspberry"
	echo -e "3)	pin SDA SBC-LCD sur pin SDA1 rasspberry"
	echo -e "4)	pin SCL SBC-LCD sur pin SCL1 rasspberry"
	echo -e "################################################################"
	echo -e "\nEntrée [ confirme ] pour confirmer que les branchement son juste\n"

read -p ": " fini_conection

if [ "$fini_conection" = "confirme" ];
then
	break
	
fi

done

# Installation resource

sudo apt install python3-dev python3-rpi.gpio
sudo git clone https://github.com/the-raspberry-pi-guy/lcd.git
cd ./lcd/
sudo rm -f demo_*.py

#---------------------
sudo wget https://raw.githubusercontent.com/00MY00/AOVPNS_lcd_fils/main/AOVPNS_lcd.py
sudo wget https://raw.githubusercontent.com/00MY00/AOVPNS_lcd_fils/main/info.sh
#---------------------

#---------------------
sudo chmod +rwx *.*
#---------------------

sudo rm -f install.sh
sudo chmod +rwx setup.sh
sudo ./setup.sh




}

lcd