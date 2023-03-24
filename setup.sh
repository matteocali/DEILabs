#!/bin/bash

echo ------ INITIAL SETUP OF DEILABS -----
echo

FILE=./data/DEILabs.conf
STARTUPFILE=./data/startup.sh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
COOKIE=./data/cookie.json

if [ ! -e "$FILE" ] ; then
    touch $FILE

    echo Insert the lab in wich you want to login \(signet, lttm, mian\):
    read labname
    echo LABNAME=$labname > $FILE
    echo

    echo Insert the path to the conda installation folder \(ENTER to set default \"~/miniconda3\"\):
    read condapath
    if [ -z "$condapath" ]; then
	    echo CONDAPATH=~/miniconda3 >> $FILE
    else
	    echo CONDAPATH=$condapath >> $FILE
    fi
    echo

    echo Insert the name of the conda environment that you plan to use \(ENTER to set default \"base\"\):
    read envname
    if [ -z "$envname" ]; then
	    echo ENVNAME=base >> $FILE
    else
	    echo ENVNAME=$envname >> $FILE
    fi
    echo

    echo Insert the Linux desktop environment that you\'re using \(gnome, kde\):
    read linuxdesktop
    echo LINUXDESKTOP=$linuxdesktop >> $FILE
    echo

    echo Insert the hour at with try the first login \(i.e. 09\):
    read firsthour
    echo FIRSTHOUR=$firsthour >> $FILE
    echo

    echo Insert the minutes at with try the first login \(i.e. 00\):
    read minutes
    echo MINUTES=$minutes >> $FILE
    echo
    
    if [ ! -e "$COOKIE" ] ; then
    	touch $COOKIE
    	echo Insert the cookie\'s name \(i.e. remember_web_*\):
    	read cookiename
    	echo
    	
    	echo Insert the cookie\'s value:
    	read cookievalue
    	echo
    	
    	echo { >> $COOKIE
        echo 	\"$cookiename\": \"$cookievalue\" >> $COOKIE
    	echo } >> $COOKIE
    fi
    
    echo SCRIPTPATH=$SCRIPTPATH >> $FILE  # Add the script path to the conf file

    echo LOCALDISPLAY=$DISPLAY >> $FILE
else
    echo The config file is already present
    echo
fi

if [ ! -e "$STARTUPFILE" ] ; then  # Generate the startupfile
    touch $STARTUPFILE
    echo cd $SCRIPTPATH >> $STARTUPFILE
    echo sh launch.sh >> $STARTUPFILE
fi

echo ------ FINISH ------
