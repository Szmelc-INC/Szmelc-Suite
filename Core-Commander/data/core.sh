#!/bin/bash
# Define the dialog options
OPTIONS=(1 "Tree > Log"
         2 "Tools"
         3 "Probe Load"
         4 "4"
         F "5"
         F1 "6"
         R "README.md")

# Define the dialog height and width
HEIGHT=15
WIDTH=25

# Display the dialog menu
CHOICE=$(dialog --clear --backtitle "ADDONS" \
                --title "SZMELC GNU ADDONS" \
                --menu "Select an option:" \
                $HEIGHT $WIDTH 2 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

# Execute the selected option
case $CHOICE in
    1)
        cd .. && sleep 1 && tree > logs/tree.txt
        #xfce4-terminal --geometry=50x25 -e "tree && sleep 10"
        ;;
    2)
        dialog --backtitle "Tools Links" --textbox tools.txt 20 75
        ;;
    3)
        bash load.sh
        ;;
    4)
        bash run-bulk.sh
        ;;
    F)
        echo "CAUTION! FORCING PORT!" && sleep 1
        bash force-port.sh
        ;;
    F1)
        echo "CAUTION! PORCING FORT!" && sleep 1
        bash porce-fort.sh
        ;;
    R)
        echo "README.md" && sleep 1
        clear && echo "" && cat README.md && echo ""
        ;;
esac

