#!/bin/bash

HEIGHT=15
WIDTH=30
CHOICE_HEIGHT=4
BACKTITLE="Csplit / SHA256 / Cebulizer"
TITLE="Select an Option"
MENU="Choose one of the following options:"

OPTIONS=(1 "Split"
         2 "Combine"
         3 "Auto sha256"
         4 "Manual sha256"
         R "README.md")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            # Execute code for Split option
            echo "Split option selected" 
            bash split.sh
            ;;
        2)
            # Execute code for Combine option
            echo "Combine option selected"
            bash combine.sh
            ;;
        3)
            # Execute code for Combine option
            echo "Computing sha256"
            sleep 1 && bash verify.sh
            ;;
        4)
            # Execute code for Combine option
            echo "Manual sha256"
            sleep 1 && bash sha256.sh
            ;;
        R)
            # Show Readme
            echo "README"
            dialog --prgbox  "cat README.md" 25 55
            ;;
esac
