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

# Check if the display is locked or not
if loginctl show-session $(loginctl | grep $(whoami) | awk '{print $1}') --property=LockedHint | grep -q "yes"; then                                                                                                             ─╯
    LOCK_STATUS=true     
else
    LOCK_STATUS=false   
fi

# Create next file if not already present
FILE=$SCRIPTPATH/data/next
if [ ! -e "$FILE" ] ; then
    echo 0 > $FILE
fi

# Read the last time of execution of at
while read line; do
    ATQ=$line
    break
done < $FILE

RANDOM_MIN=$(shuf -i 30-60 -n 1)  # Define a random number of minutes between 30 and 60
RANDOM_SEC=$(shuf -i 0-59 -n 1)  # Define a random number of seconds between 0 and 59

CURRENT_DISPLAY=$DISPLAY # $($PYTHONPATH/python3 -c "import subprocess; print(subprocess.run(['w', '-h', '-s'], stdout=subprocess.PIPE).stdout.decode('utf-8').strip().split()[2])")

# Execute the login script and reschedule
if [ $LOCK_STATUS = false ]; then
	if [ $CURRENT_DISPLAY = $LOCALDISPLAY ]; then
		sleep "$RANDOM_SEC"s
		OUT=$($PYTHONPATH/python3 $SCRIPTPATH/data/deilabs_no_choice.py -l $LABNAME)
		notify-send -u critical -i $SCRIPTPATH/data/DEILabs_logo_icon.png DEILabs "$OUT"  # Notify the user about the login
		
		VERSIONMSG=$($PYTHONPATH/python3 $SCRIPTPATH/data/version_checker.py)
		if [ ! -z "$VERSIONMSG" ]; then
			notify-send -u normal -i $SCRIPTPATH/data/DEILabs_logo_icon.png DEILabs "$VERSIONMSG"  # Notify the user about the available update
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

