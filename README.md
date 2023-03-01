# DEILabs
Script to automatically login on the DEILabs platform. The scripts only works on Linux 

## Installaztion instruction
1) create a conda environment from the dei_labs.yml file
2) open "https://deilabs.dei.unipd.it/laboratory_in_outs" in a browser
3) login with DEI credentials and mark the "remembre me" checkbox
4) from teh dev-tools of the browser copy the "remember_web_*" cookies's value
5) past the value in the login variable of the "deilabs-no-choice.py" script
6) open "launch.sh" and select the lab to login to (signet or lttm)
7) ad a startup process to execute launch.sh (In gnome using startup application)
8) if not already installed install qdbus
