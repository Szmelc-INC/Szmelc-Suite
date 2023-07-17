#!/bin/bash

# SZMELC OS [MX-21.3 Fork] 
# Install shell scripts with 'dialog' GUI
# By Szmelc.INC - SilverX
# For MX Linux / Debian 11 

# Define the menu options
OPTIONS=(1 "1"
         2 "2"
         3 "3"
         4 "4"
         E "Exit")

# Define the menu title
TITLE=" [Extra] "

# Set the terminal emulator to monochrome
tput initc 7 0 0 0
tput initc 0 1000 1000 1000
tput initc 10 10 10 10
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
    1) # Run Script 1
        bash extra/e1.sh
        ;;
    2) # Run Script 2
        bash extra/e2.sh
        ;;
    3) # Run Script 3
        bash extra/e3.sh
        ;;
    4) # Run Script 4
        bash extra/e4.sh
        ;;
    E) # Exit
        clear && echo "" && echo " Thanks for choosing Szmelc <3 " && echo "" && exit
        ;;
esac
