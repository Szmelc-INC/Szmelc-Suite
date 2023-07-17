#!/bin/bash

# SZMELC OS [MX-21.3 Fork] 
# Install shell scripts with 'dialog' GUI
# By Szmelc.INC - SilverX
# For MX Linux / Debian 11 

# Define the menu options
OPTIONS=(1 "Install Packages - [APT]"
         2 "Add Repos & Keyrings"
         3 "Docs - [README.md]"
         4 "Misc"
         E "Exit")

# Define the menu title
TITLE=" [Install Szmelc] "

# Set the terminal emulator to monochrome
# Uncomment all tput for Negative Black theme
# Comment out remaining tput for 98-Blue theme
# tput initc 7 0 0 0
# tput initc 0 1000 1000 1000
# tput initc 10 10 10 10
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
    1) # Post Install Config
        bash apt/main.sh
        ;;
    2) # Run Script 2
        bash repos/main.sh
        ;;
    3) # Run Script 3
        bash docs/main.sh
        ;;
    4) # Run Script 4
        bash misc/main.sh
        ;;
    E) # Exit
        clear && echo "" && echo " Thanks for choosing Szmelc <3 " && echo "" && exit
        ;;
esac

