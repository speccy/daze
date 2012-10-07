#!/bin/bash

#Colours
black="#b3b3b3"
red="#EA8484"
green="#C7F09F"
yellow="#FFCC9A"
blue="#A5CAEF"
magenta="#A6A6DE"
cyan="#95CDCD"
white="#d7d7d7"
grey="#848484"
pink="#FFA4E5"

FONT="-*-fixed-*-*-*-*-12-*-*-*-*-*-sio10646-*"
XPOS=$(xdotool getmouselocation | awk -F " " '{print $1}' | cut -d ":" -f 2)
YPOS="20"
HEIGHT="15"
WIDTH="300"
torrentcount=$(transmission-remote -l | wc -l)
let torrentcount=torrentcount-1
LINES="$torrentcount"

loop=$(
for (( i = 2; i <= $torrentcount; i++ ));
	do
		etastatus=$(transmission-remote -l | sed -n ""$i"p" | awk -F " " '{print $5}')

		if [ $etastatus == 'Unknown' ]; then
			name=$(transmission-remote -l | sed -n ""$i"p" | awk '{for (j=10; j <= NF; j++) print $j}' | paste -sd " ")
			percent=$(transmission-remote -l | sed -n ""$i"p" | awk -F " " '{print $2}')
			have=$(transmission-remote -l | sed -n ""$i"p" | awk -F " " '{print $3 $4}')
			ETA=$(transmission-remote -l | sed -n ""$i"p" | awk -F " " '{print $5}')
			status=$(transmission-remote -l | sed -n ""$i"p" | awk -F " " '{print $9}')
		else
			name=$(transmission-remote -l | sed -n ""$i"p" | awk '{for (j=11; j <= NF; j++) print $j}' | paste -sd " ")
			percent=$(transmission-remote -l | sed -n ""$i"p" | awk -F " " '{print $2}')
			have=$(transmission-remote -l | sed -n ""$i"p" | awk -F " " '{print $3 $4}')
			ETA=$(transmission-remote -l | sed -n ""$i"p" | awk -F " " '{print $5 $6}')
			status=$(transmission-remote -l | sed -n ""$i"p" | awk -F " " '{print $10}')
		fi	

		echo "$name $status $percent $have $ETA"
	done)

(echo "^fg($white) Currently downloading"; echo "^fg($white)Name         Status   Done Have   ETA"; echo "$loop"; sleep 15) | dzen2 -bg "#2C2C2C" -fn $FONT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse;button1=exit;button3=exit'
