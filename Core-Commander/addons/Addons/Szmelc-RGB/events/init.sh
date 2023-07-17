#!/bin/bash

# Define the menu options
OPTIONS=(1 "DynamiX"
         2 "Events"
         3 "Keybinds"
         4 "Config"
         5 "Docs - [README.md]"
         E "Exit")

# Define the menu title
TITLE=" [Szmelc RGB Events] "

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
    1) # 1
        bash events/dx.sh
        ;;
    2) # Run Script 2
        bash events/events.sh
        ;;
    3) # Run Script 3
        bash events/keybinds.sh
        ;;
    4) # Run Script 4
        nano events/config.txt
        ;;
    5) # print Readme
        cat events/README.md
        ;;
    E) # Exit
        clear && echo "" && echo " Thanks for choosing Szmelc <3 " && echo "" && exit
        ;;
esac

sleep 1
bash exec.sh
