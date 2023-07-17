#!/bin/bash

# SZMELC OS [MX-21.3 Fork] 
# Install shell scripts with 'dialog' GUI
# By Szmelc.INC - SilverX
# For MX Linux / Debian 11 

# Define the menu options
OPTIONS=(1 "Install Packages"
         2 "Add / Remove Packages"
         3 "List & Log Installed"
         4 "More [README.md]"
         E "Exit")

# Define the menu title
TITLE=" [APT] "

tput initc 4 250 250 250

# Show the menu and capture the user's selection
CHOICE=$(dialog --clear \
                --title "$TITLE" \
                --menu "Choose one of the following options:" \
                15 40 5 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

# Handle the user's selection
case "$CHOICE" in
    1) # Install
        bash apt/install.sh
        ;;
    2) # Add / Remove
        nano apt/packages.txt
        ;;
    3) # List & Log all installed packages
        apt list > apt/logs/installed_packages.txt && echo "" && echo "Saved into logs/installed_packages.txt log"
        xfce4-terminal --geometry=50x25 -e "bash -c 'apt list | lolcat; sleep 1'"
        ;;
    4) # Run Script 4
        clear && echo "[README.md]" && cat apt/README.md
        ;;
    E) # Exit
        clear && echo "" && echo " Thanks for choosing Szmelc <3 " && echo "" && exit
        ;;
esac

sleep 1 && bash exec.sh
