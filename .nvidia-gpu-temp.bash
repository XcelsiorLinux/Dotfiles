#!/bin/sh
# Shell script to add CPU temperature and GPU temperature from a Nvidia GPU using proprietary driver to i3bar
i3status | (read line && echo $line && read line && echo $line && while :
do
	read line
	
  	cpu=$(sensors | grep temp1 | awk '{print $2;}' | tr -d '+')
	gpu=$(nvidia-smi -q -d TEMPERATURE | grep Current | awk '{print $5;}')
	
	text="[{ \"full_text\": \" AMD FX8350: ${cpu}\" },{ \"full_text\": \" Nvidia GTX670: ${gpu}°C\" },"
	
	echo  "${line/[/$text}" || exit 1
done)
