#!/bin/bash

#Colours
black="#b3b3b3"
red="#924944"
green="#C7F09F"
yellow="#FFCC9A"
blue="#536979"
magenta="#A6A6DE"
cyan="#95CDCD"
white="#9C9FA1"
grey="#848484"
pink="#FFA4E5"

FONT="-*-cure-*-*-*-*-*-*-*-*-*-*-*-*"
XPOS=$(xdotool getmouselocation | awk -F " " '{print $1}' | cut -d ":" -f 2)
YPOS="20"
HEIGHT="15"
WIDTH="274"
LINES="11"

cputemp=$(sensors | sed -n "3p" | awk -F " " '{print $4}' | sed "s/+//" | cut -c1-2,5-)
cpuutiluser=$(iostat -c | sed -n "4p" | awk -F " " '{print $1}')
cpuutilsystem=$(iostat -c | sed -n "4p" | awk -F " " '{print $3}')
cpuutilidle=$(iostat -c | sed -n "4p" | awk -F " " '{print $6}')
ramtotal=$(free -m | sed -n "2p" | awk -F " " '{print $2}')
ramused=$(free -m | sed -n "2p" | awk -F " " '{print $3}')
gputemp=$(sensors | sed -n "4p" | awk -F " " '{print $2}' | sed "s/+//" )
gpuramtotal=$(nvidia-smi -a | grep "Total" | head -1 | cut -d ":" -f 2 | sed "s/\ MB//")
gpuramused=$(nvidia-smi -a | grep "Used" | cut -d ":" -f 2 | sed "s/\ MB//")
gpufan=$(nvidia-smi -a | grep "Fan Speed" | cut -d ":" -f 2)
gpudriver=$(nvidia-smi -a | grep "Driver Version" | head -1 | cut -d ":" -f 2)


hdd1=$(df -h | grep "/dev/sd" | sed -n "1p")
hdd2=$(df -h | grep "/dev/sd" | sed -n "2p")
hdd3=$(df -h | grep "/dev/sd" | sed -n "3p")
hdd4=$(df -h | grep "/dev/sd" | sed -n "4p")
hdd5=$(df -h | grep "/dev/sd" | sed -n "5p")
hdd6=$(df -h | grep "/dev/sd" | sed -n "6p")

hddtitle=$(df -h | head -1)
hddtotal=$(df -h --total | tail -1)

(echo "^fg($white)System"; echo "^fg($blue)[RAM]"; echo "Used: $ramused MB / $ramtotal MB"; echo " "; echo "^fg($blue)[GPU]";echo "Temp:^fg($white) $gputemp";echo ""; echo "^fg($blue)[HDD]"; echo "$hddtitle"; echo "$hdd1"; echo "$hdd2"; echo "$hddtotal"; sleep 15) | dzen2 -bg "#1C1C1C" -fn $FONT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse;button1=exit;button3=exit'
