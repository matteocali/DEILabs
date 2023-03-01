# DEILabs
Script to automatically login on the DEILabs platform. 

![Linux](https://img.shields.io/badge/Linux-partially%20supported-yellow?style=flat&logo=ubuntu)
![GNOME](https://img.shields.io/badge/GNOME-supported-success?style=flat&logo=gnome)
![KDE](https://img.shields.io/badge/KDE-supported-success?style=flat&logo=kde)

![Windows](https://img.shields.io/badge/Windows-not%20supported-critical?style=flat&logo=windows)

## Installation instruction
1) create a conda environment from the ![dei_labs.yml](data/dei_labs.yml) file
2) if not already installed, install `at` and `qdbus`
   ```
   sudo apt update
   sudo apt install at -y
   sudo apt install qdbus -y
   ```
3) open the ![DEILabs](https://deilabs.dei.unipd.it/laboratory_in_outs) web page in a browser
4) login with the DEI credentials and mark the "remembre me" checkbox
5) from the `dev-tools` of the browser copy the `remember_web_*` cookies's value (Firefox instruction following)
   - from the option menu select `More tools` > `Web Developer Tools`
   - from the newly opened window select `Storage` > `Cokies`
   - double click on the `value` field of `remember_web_59ba36addc2b2f9401580f014c7f58ea4e30989d` and copy the value
6) past the value in the login variable of the ![deilabs-no-choice.py](deilabs-no-choice.py) script
7) open "launch.sh" and select the lab to login to (chosing from the supported ones)
8) ad a startup process to execute ![launch.sh](launch.sh) (In gnome using startup application) in order to ensure that the script works also after a system reboot
9) run the ![launch.sh](launch.sh) script from the temrinal


## Supported labs
List of the supported labs
* lttm
* signet
* mian
