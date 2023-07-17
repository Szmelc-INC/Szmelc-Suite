#!/bin/bash

# Define the menu options
OPTIONS=(1 "Play Effects"
         2 "Community Effects"
         3 "Backup Local"
         4 "Events API"
         5 "Docs - [README.md]"
         E "Exit")

# Define the menu title
TITLE=" [Szmelc RGB] "

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
        bash play.sh
        ;;
    2) # Run Script 2
        bash wget.sh
        ;;
    3) # Run Script 3
        bash backup.sh
        ;;
    4) # Run Script 4
        bash events/main.sh
        ;;
    5) # print Readme
        cat README.md
        ;;
    E) # Exit
        clear && echo "" && echo " Thanks for choosing Szmelc <3 " && echo "" && exit
        ;;
esac

