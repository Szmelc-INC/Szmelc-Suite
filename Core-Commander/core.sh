#!/bin/bash
# Define the dialog options

OPTIONS=(1 "Addons"
         2 "Data"
         3 "3"
         4 "4"
         F "5"
         R "README.md")

# Define the dialog height and width
HEIGHT=15
WIDTH=25

# Display the dialog menu
CHOICE=$(dialog --clear --backtitle "CENTRAL COMMAND PANEL" \
                --title "SZMELC GNU - CCP" \
                --menu "Select an option:" \
                $HEIGHT $WIDTH 2 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

# Execute the selected option
case $CHOICE in
    1)
        cd addons && bash core.sh
        ;;
    2)
        cd data && bash core.sh
        ;;
    3)
        bash run.sh
        ;;
    4)
        bash run-bulk.sh
        ;;
    F)
        echo "CAUTION! FORCING PORT!" && sleep 1
        bash force-port.sh
        ;;
    R)
        echo "README.md" && sleep 1
        clear && echo "" && cat README.md && echo ""
        ;;
esac

