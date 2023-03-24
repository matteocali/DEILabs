![DEILabs_logo](data/DEILabs_logo.png)

# Auto DEILabs login script

Script to automatically log in to the DEILabs platform.

![Version](https://img.shields.io/badge/dynamic/json?color=informational&label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fmatteocali%2FDEILabs%2Fmain%2Fdata%2Fversion.json)

![Ubuntu](https://img.shields.io/badge/Ubuntu-partially%20supported-yellow?style=flat&logo=ubuntu)
![GNOME](https://img.shields.io/badge/GNOME-supported-success?style=flat&logo=gnome)
![KDE](https://img.shields.io/badge/KDE-supported-success?style=flat&logo=kde)

![Windows](https://img.shields.io/badge/Windows-not%20supported-critical?style=flat&logo=windows)
![MacOS](https://img.shields.io/badge/MacOS-not%20supported-critical?style=flat&logo=apple)

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
4) log in with the DEI credentials and mark the "remember me" checkbox
5) from the `dev-tools` of the browser copy the `remember_web_*` cookies' name and value (Firefox instruction following)
   - from the option menu select `More tools` > `Web Developer Tools`
   - from the newly opened window select `Storage` > `Cookies`
   - double click on the `value` field of `remember_web_*` and copy the value
6) open a terminal instance in the cloned folder and run `bash setup.sh`, follow the instruction filling in all the required data (this command must be executed inside a local session!):
   - the lab to login to (choosing from the supported ones)
   - the conda environment to use
   - the desktop environment to use (gnome or kde)
   - the daytime for the first daily login attempt
   - the `remember_web_*` cookies' name and value
7) add a startup process to execute ![launch.sh](launch.sh) in order to ensure that the script works also after a system reboot
   - open `Startup Applications` (GUI application preinstalled in Ubuntu)
   - add a new entry called "DEILabs" that execute the following command `sh <script_path>/data/startup.sh`
8) run for the first time the ![launch.sh](launch.sh) script from the temrinal: `cd <script_path> && sh launch.sh`

## Supported labs

List of the supported labs

- lttm
- signet
- mian

## TO-DO

- [x] If connected via RDP do not perform any log in (idea: use the $DISPLAY var, if > 3 do not log in)
- [ ] Add more labs
- [ ] Add Windows support
- [ ] Add MacOS support
