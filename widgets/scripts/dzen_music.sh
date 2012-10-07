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
echo "$xposa $xposb $xposc $XPOS"
YPOS="20"
HEIGHT="15"
WIDTH="200"
LINES="3"

playing=$(mpc current)
stats=$(mpc stats)
#playlist=$(mpc playlist | sed "s/$playing/> $playing/")
playlistcurrent=$(mpc playlist | grep -n "$playing" | cut -d ":" -f 1)
nextnum=$(( $playlistcurrent + 1 ))
prevnum=$(( $playlistcurrent - 1 ))
next=$(mpc playlist | sed -n ""$nextnum"p")
prev=$(mpc playlist | sed -n ""$prevnum"p")


(echo "Music"; echo "^fg($blue)Playing:^fg() $playing"; echo "^fg($blue)Next:^fg() $next"; echo "^fg($blue)Previous:^fg() $prev";sleep 15) | dzen2 -bg "#1C1C1C" -fn $FONT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse;button1=exit;button3=exit'

#(echo "Music"; echo "^fg($blue)Playing:^fg() $playing"; echo "^fg($blue)Next:^fg() $next"; echo "^fg($blue)Previous:^fg() $prev"; echo " "; echo "$stats"; sleep 15) | dzen2 -bg "#1C1C1C" -fn $FONT -x $XPOS -y $YPOS -w $WIDTH -l $LINES -e 'onstart=uncollapse;button1=exit;button3=exit'
