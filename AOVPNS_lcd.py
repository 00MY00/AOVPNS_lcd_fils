#! /usr/bin/env python

# Simple string program. Writes and updates strings.
# Demo program for the I2C 16x2 Display from Ryanteck.uk
# Created by Matthew Timmons-Brown for The Raspberry Pi Guy YouTube channel

# Import necessary libraries for communication and display use
import drivers
import VPN_server_info
import subprocess
from time import sleep


# Load the driver and set it to "display"
# If you use something from the driver library use the "display." prefix first
display = drivers.Lcd()

cut=len(VPN_server_info.date)
cut=int(cut) // 2
date1=VPN_server_info.date[0:cut]
date2=VPN_server_info.date[cut:]
users=VPN_server_info.user.split(" ")
max_user=len(users)

# Main body of code
try:
    while True:
        # Max 16 caractèr
        print("Affichage sur LCD")
        display.lcd_display_string("le ssh est", 1)  
        display.lcd_display_string(f"{VPN_server_info.SSH}", 2)  
        sleep(2)
        display.lcd_clear()                                
        display.lcd_display_string("OpenVPN est", 1)  
        display.lcd_display_string(f"{VPN_server_info.VPN}", 2)  
        sleep(2)
        display.lcd_clear()  
        display.lcd_display_string("La date est", 1)  
        display.lcd_display_string(f"{date1}", 2)  
        sleep(2)                                           
        display.lcd_clear() 
        display.lcd_display_string("La date est", 1)  
        display.lcd_display_string(f"{date2}", 2)  
        sleep(3) 
        for i in range(0, max_user):
            display.lcd_clear() 
            display.lcd_display_string("Users conectée", 1)
            display.lcd_display_string(f"{users[i]}", 2)
            sleep(2)
            display.lcd_clear()    
          
        subprocess.call(["sh","info.sh"])
except KeyboardInterrupt:
    # If there is a KeyboardInterrupt (when you press ctrl+c), exit the program and cleanup
    print("Cleaning up!")
    display.lcd_clear()
