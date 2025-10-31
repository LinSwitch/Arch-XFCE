#!/bin/bash
updates=$(checkupdates 2>/dev/null | wc -l)
if [ "$updates" -gt 0 ]; then
	echo "<tool>Доступны обновления!</tool>"
	echo "<txt>❗$updates</txt>"
	echo "<txtclick>/home/$USER/.config/scripts/update.sh</txtclick>"
else
	echo "<txt>  ✔️ </txt>"
	echo "<tool>Система актуальна!</tool>"
	
fi
 