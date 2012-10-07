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
XPOS="1700"
YPOS="20"
HEIGHT="15"
WIDTH="200"
pacmanlines=$(pacman -Qu | wc -l)
LINES=$(( $pacmanlines + 2 ))

updates=$(pacman -Qu)

(echo "^fg($white)Updates"; echo "$updates"; echo " "; echo "^fg($white)Right click to update";sleep 15) | dzen2 -bg "#2C2C2C" -fn $FONT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse;button1=exit;button3=urxvt'
