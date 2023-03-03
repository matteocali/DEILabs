#!/bin/bash

### USER DEFINED VAR
. data/DEILabs.conf


### PREDEFINED VAR (do not modify)
BASEENV=base

# Set env path
if [ $ENVNAME = base ]; then
	ENVPATH=$CONDAPATH
else
	ENVPATH=$CONDAPATH/envs/$ENVNAME
fi

PYTHONPATH=$ENVPATH/bin

# Set Linux Desktop
if [ $LINUXDESKTOP = gnome ]; then
	LOCK_STATUS=$(qdbus org.gnome.ScreenSaver /org/gnome/ScreenSaver org.gnome.ScreenSaver.GetActive)  # For GNOME
else
	LOCK_STATUS=$(qdbus org.freedesktop.ScreenSaver /ScreenSaver GetActive)  # For KDE
fi

# Create next file if not already present
FILE=$SCRIPTPATH/data/next
if [ ! -e "$FILE" ] ; then
    echo 0 > $FILE
fi

# Reade the list time of execution of at
while read line; do
    ATQ=$line
    break
done < $FILE

RANDOM_MIN=$(shuf -i 30-60 -n 1)  # Define a random number of minutes between 30 and 60

CURRENT_DISPLAY=$($PYTHONPATH/python3 -c "import subprocess; print(subprocess.run(['w', '-h', '-s'], stdout=subprocess.PIPE).stdout.decode('utf-8').strip().split()[2])")

# Execute the login script and reschedule
if [ $LOCK_STATUS = false ]; then
	if [ $CURRENT_DISPLAY = $LOCALDISPLAY ]; then
		OUT=$($PYTHONPATH/python3 $SCRIPTPATH/data/deilabs_no_choice.py -l $LABNAME)
		notify-send -u critical -i /usr/share/icons/gnome/scalable/places/poi-building.svg DEILabs "$OUT"  # Notify the user about the login
		
		VERSIONMSG=$($PYTHONPATH/python3 $SCRIPTPATH/data/version_checker.py)
		if [ ! -z "$VERSIONMSG" ]; then
			notify-send -u normal -i /usr/share/icons/gnome/scalable/places/poi-building.svg DEILabs "$VERSIONMSG"  # Notify the user about the available update
		fi
	fi
	
	RES=$(( $ATQ <= $(date +%s) ))
	if [ $RES = 1 ]; then
		echo $(date +%s -d "$FIRSTHOUR:$MINUTES tomorrow") > $FILE
		at $FIRSTHOUR:$MINUTES tomorrow -f $SCRIPTPATH/launch.sh  # Add a job for tomorrow only if not already present
	fi
else
	echo $(date +%s -d "now + $RANDOM_MIN min") > $FILE
	at now + $RANDOM_MIN min -f $SCRIPTPATH/launch.sh
fi

