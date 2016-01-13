#!/bin/sh
# Shell script to add CPU temperature and GPU temperature from an AMD GPU using proprietary driver to i3bar
i3status | (read line && echo $line && read line && echo $line && while :
do
	read line
	
  	cpu=$(sensors | grep temp1 | awk '{print $2;}' | tr -d '+')
	gpu=$(aticonfig --adapter=0 --od-gettemperature | grep Sensor | awk '{print $5;}' | cut -c -2)
	
	text="[{ \"full_text\": \" Athlon x4 860K: ${cpu}\" },{ \"full_text\": \" Radeon R7 370: ${gpu}°C\" },"
	
	echo  "${line/[/$text}" || exit 1
done)
