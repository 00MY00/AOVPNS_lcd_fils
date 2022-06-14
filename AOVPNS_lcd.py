#! /usr/bin/env python

# Met à jour des chaînes de caractères.
# Programme de démonstration pour l'écran I2C 16x2 de Ryanteck.uk.
# Créé par Matthew Timmons-Brown pour la chaîne YouTube "The Raspberry Pi Guy".
# retatravailler par kuroakashiro (Alec)

# Importe les bibliothèques nécessaires pour la communication et l'utilisation de l'écran
import drivers
import VPN_server_info
import subprocess


from time import sleep


# Chargement du pilote et définition par "display".
# Si vous utilisez un élément de la bibliothèque de pilote, utilisez d'abord le préfixe "display".
display = drivers.Lcd()

cut=len(VPN_server_info.date)
cut=int(cut) // 2
date1=VPN_server_info.date[0:cut]
date2=VPN_server_info.date[cut:]
users=VPN_server_info.user.split(" ")
max_user=len(users)

# code principale
try:
    while True:
        # Max 16 caractère
        print("Affichage sur LCD")
        display.lcd_display_string("le SSH est", 1)  
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
        sleep(2) 
        for i in range(0, max_user):
            display.lcd_clear() 
            display.lcd_display_string(f"Users {i} conecter", 1)
            display.lcd_display_string(f"{users[i]}", 2)
            sleep(2)
            display.lcd_clear()    
          
        import subprocess
        subprocess.call(["./info.sh"])
except KeyboardInterrupt:
    print("Cleaning up!")
    display.lcd_clear()
