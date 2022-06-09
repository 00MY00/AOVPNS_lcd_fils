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
rm -f demo_*.py

#---------------------
# Affichage du LCD
echo -e "#! /usr/bin/env python" >> AOVPNS_lcd.py

echo -e "# Simple string program. Writes and updates strings." >> AOVPNS_lcd.py
echo -e "# Demo program for the I2C 16x2 Display from Ryanteck.uk" >> AOVPNS_lcd.py
echo -e "# Created by Matthew Timmons-Brown for The Raspberry Pi Guy YouTube channel" >> AOVPNS_lcd.py

echo -e "# Import necessary libraries for communication and display use" >> AOVPNS_lcd.py
echo -e "import drivers" >> AOVPNS_lcd.py
echo -e "import VPN_server_info" >> AOVPNS_lcd.py
echo -e "import subprocess" >> AOVPNS_lcd.py
echo -e "from time import sleep" >> AOVPNS_lcd.py

echo -e "# Load the driver and set it to \"display\"" >> AOVPNS_lcd.py
echo -e "# If you use something from the driver library use the \"display.\" prefix first" >> AOVPNS_lcd.py
echo -e "display = drivers.Lcd()" >> AOVPNS_lcd.py

echo -e "cut=len(VPN_server_info.date)" >> AOVPNS_lcd.py
echo -e "cut=int(cut) // 2" >> AOVPNS_lcd.py
echo -e "date1=VPN_server_info.date[0:cut]" >> AOVPNS_lcd.py
echo -e "date2=VPN_server_info.date[cut:]" >> AOVPNS_lcd.py

echo -e "# Main body of code" >> AOVPNS_lcd.py
echo -e "try:" >> AOVPNS_lcd.py
echo -e "    while True:" >> AOVPNS_lcd.py
echo -e "        # Max 16 caractèr" >> AOVPNS_lcd.py
echo -e "        print(\"Affichage sur LCD\")" >> AOVPNS_lcd.py
echo -e "        display.lcd_display_string(\"le ssh est\", 1)" >> AOVPNS_lcd.py
echo -e "        display.lcd_display_string(f\"{VPN_server_info.SSH}\", 2)" >> AOVPNS_lcd.py
echo -e "        sleep(2)" >> AOVPNS_lcd.py
echo -e "        display.lcd_clear()" >> AOVPNS_lcd.py                                
echo -e "        display.lcd_display_string(\"OpenVPN est\", 1)" >> AOVPNS_lcd.py  
echo -e "        display.lcd_display_string(f\"{VPN_server_info.VPN}\", 2)" >> AOVPNS_lcd.py  
echo -e "        sleep(2)" >> AOVPNS_lcd.py
echo -e "        display.lcd_clear()" >> AOVPNS_lcd.py  
echo -e "        display.lcd_display_string(\"La date est\", 1)" >> AOVPNS_lcd.py  
echo -e "        display.lcd_display_string(f\"{date1}\", 2)" >> AOVPNS_lcd.py  
echo -e "        sleep(2)" >> AOVPNS_lcd.py                                           
echo -e "        display.lcd_clear()" >> AOVPNS_lcd.py 
echo -e "        display.lcd_display_string(\"La date est\", 1)" >> AOVPNS_lcd.py  
echo -e "        display.lcd_display_string(f\"{date2}\", 2)" >> AOVPNS_lcd.py  
echo -e "        sleep(3)" >> AOVPNS_lcd.py 
echo -e "        display.lcd_clear()" >> AOVPNS_lcd.py                                
echo -e "        subprocess.call([\"sh\",\"info.sh\"])" >> AOVPNS_lcd.py
echo -e "except KeyboardInterrupt:" >> AOVPNS_lcd.py
echo -e "    print(\"Cleaning up!\")" >> AOVPNS_lcd.py
echo -e "    display.lcd_clear()" >> AOVPNS_lcd.py
#---------------------


#---------------------
sudo chmod +rwx *.*
#---------------------

rm -f install.sh
sudo chmod +rwx setup.sh
sudo ./setup.sh




}

lcd