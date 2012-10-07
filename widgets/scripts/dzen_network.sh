#!/bin/bash

#Colours
black="#b3b3b3"
red="#EA8484"
green="#C7F09F"
yellow="#FFCC9A"
blue="#536979"
magenta="#A6A6DE"
cyan="#95CDCD"
white="#d7d7d7"
grey="#848484"
pink="#FFA4E5"

FONT="-*-cure-*-*-*-*-*-*-*-*-*-*-*-*"
XPOS=$(xdotool getmouselocation | awk -F " " '{print $1}' | cut -d ":" -f 2)
YPOS="20"
HEIGHT="15"
WIDTH="110"
LINES="5"

dailyrx=$(vnstat --oneline | awk -F ";" '{print $4}')
dailytx=$(vnstat --oneline | awk -F ";" '{print $5}')
alltimerx=$(vnstat --oneline | awk -F ";" '{print $13}')
alltimetx=$(vnstat --oneline | awk -F ";" '{print $14}')

#externalip=$(curl -silent www.myip.se | grep "Your IP address : " | awk -F " " '{print $5}' | cut -d "<" -f 1)

(echo "Network"; echo "^fg($blue)Daily up:^fg() $dailytx"; echo "^fg($blue)Daily down: ^fg()$dailyrx"; echo "^fg($blue)Alltime up: ^fg()$alltimetx"; echo "^fg($blue)Alltime down: ^fg()$alltimerx"; echo "^fg($blue)External IP: ^fg()85.***.*.***"; sleep 15) | dzen2 -bg "#1C1C1C" -fn $FONT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse;button1=exit;button3=exit'
