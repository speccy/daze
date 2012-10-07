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

FONT="-*-cure-*-*-*-*-*-*-*-*-*-*-*-*"
XPOS=1812
YPOS="20"
HEIGHT="15"
WIDTH="105"
LINES="6"

TODAY=$(expr `date +'%d'` + 0)

totaldays=$(date +"%j")
totalweeks=$(date +"%U")
sydneytime=$(TZ="Australia/Sydney" date | awk -F " " '{print $4}')
calendar=$(cal | sed -r -e "1 s/.*/^fg(#536979)&^fg()/" -e "s/(^| )($TODAY)($| )/\1^bg(#1c1c1c)^fg(#536979)\2^fg()^bg()\3/"
)
timealivesecs=$(date -d 1995-02-07 +%s)
timealivedays=$(( $timealivesecs / 86400 ))

(echo "$calendar"; sleep 15) | dzen2 -bg "#1C1C1C" -fn $FONT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse;button1=exit;button3=exit'
