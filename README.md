# DEILabs
Script to automatically login on the DEILabs platform. 

![Version](https://img.shields.io/badge/Version-1.1.0-informational?style=flat)

![Linux](https://img.shields.io/badge/Linux-partially%20supported-yellow?style=flat&logo=ubuntu)
![GNOME](https://img.shields.io/badge/GNOME-supported-success?style=flat&logo=gnome)
![KDE](https://img.shields.io/badge/KDE-supported-success?style=flat&logo=kde)

![Windows](https://img.shields.io/badge/Windows-not%20supported-critical?style=flat&logo=windows)

## Installation instruction
Installation guide:
1) create a conda environment from the ![dei_labs.yml](data/dei_labs.yml) file
2) if not already installed, install `at` and `qdbus`
   ```
   sudo apt update
   sudo apt install at -y
   sudo apt install qdbus -y
   ```
3) open the ![DEILabs](https://deilabs.dei.unipd.it/) web page in a browser
4) login with the DEI credentials and mark the "remembre me" checkbox
5) from the `dev-tools` of the browser copy the `remember_web_*` cookies's name and value (Firefox instruction following)
   - from the option menu select `More tools` > `Web Developer Tools`
   - from the newly opened window select `Storage` > `Cokies`
   - double click on the `value` field of `remember_web_*` and copy the value
6) paste the value in the login variable of the ![deilabs-no-choice.py](deilabs-no-choice.py) script
7) open ![launch.sh](launch.sh) script using an editor and set the various user parameteres:
   - the lab to login to (chosing from the supported ones)
   - the conda environment to use
   - the path where the script ![launch.sh](launch.sh) is located
   - the desktop environment to use (GNOME or KDE)
   - the day time for the first daily login attempt
8) add a startup process to execute ![launch.sh](launch.sh) in order to ensure that the script works also after a system reboot
   - open `Startup Applications` (GUI application preinstaled in Ubuntu)
   - add a new entry called "DEILabs" that execute the following command `bash <path_script>/launch.sh`
10) run the ![launch.sh](launch.sh) script from the temrinal


## Supported labs
List of the supported labs
* lttm
* signet
* mian


## TO-DO
- [x] If connected via RDP do not perform any login (idea: use the $DISPLAY var, if > 3 do not login)
- [ ] Add Windows support 
