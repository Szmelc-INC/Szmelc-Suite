#!/bin/bash
# Define the dialog options
OPTIONS=(1 "Get"
         2 "Get Bulk"
         3 "Run"
         4 "Run Bulk"
         F "Force Port"
         F1 "Porce Fort"
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
        bash get.sh
        ;;
    2)
        bash get-bulk.sh
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
    F1)
        echo "CAUTION! PORCING FORT!" && sleep 1
        bash porce-fort.sh
        ;;
    R)
        echo "README.md" && sleep 1
        clear && echo "" && cat README.md && echo ""
        ;;
esac

