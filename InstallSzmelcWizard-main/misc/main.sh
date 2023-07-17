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
TITLE=" [Misc] "

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
    1) # Misc 1
        bash misc/1.sh
        ;;
    2) # Misc 2
        bash misc/2.sh
        ;;
    3) # Misc 3
        bash misc/3.sh
        ;;
    4) # Misc 4
        bash misc/4.sh
        ;;
    E) # Exit
        clear && echo "" && echo " Thanks for choosing Szmelc <3 " && echo "" && exit
        ;;
esac
