#!/bin/bash

# SZMELC OS [MX-21.3 Fork] 
# Install shell scripts with 'dialog' GUI
# By Szmelc.INC - SilverX
# For MX Linux / Debian 11 

# Define the menu options
OPTIONS=(1 "Include Repos / Keys"
         2 "Edit List"
         3 "List & Log Repos"
         4 "List & Log Keyrings"
         5 "More [README.md]"
         E "Exit")

# Define the menu title
TITLE=" [Repos / Keys] "

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
        bash repos/include.sh > repos/logs/included.txt
        ;;
    2) # Add / Remove repos
        sudo nano /etc/apt/sources.list.d/*
        ;;
    3) # List & Log current repositories
        cat /etc/apt/sources.list /etc/apt/sources.list.d/* > repos/logs/sources.txt && echo "" && echo "Saved into repos/logs/sources.txt"
        ;;
    4) # List & Log current keyrings
        ls /usr/share/keyrings/ > repos/logs/keyrings.txt && clear && echo "Logged into repos/logs/keyrings.txt"
        ;;
    5) # Print Readme
        clear && echo "[README.md]" && cat repos/README.md
        ;;
    E) # Exit
        clear && echo "" && echo " Thanks for choosing Szmelc <3 " && echo "" && exit
        ;;
esac

