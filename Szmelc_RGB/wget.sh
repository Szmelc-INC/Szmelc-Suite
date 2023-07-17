#!/bin/bash

clear && echo "" && echo " Downloading Community Effects from " 
echo "https://github.com/GNU-Szmelc/Szmelc-RGB" && echo "" && sleep 1

USERNAME=$(whoami)
# Download the effects directory from the Szmelc-RGB repository
curl -L https://github.com/GNU-Szmelc/Szmelc-RGB/archive/refs/heads/main.zip -o Szmelc-RGB.zip
unzip -q Szmelc-RGB.zip 'Szmelc-RGB-main/effects/*.json'

# List the loaded effects
echo ""
echo "Loaded effects:"
echo "-------------------"
ls -1 /home/${USERNAME}/.config/polychromatic/effects/*.json
echo "-------------------"

# List the downloaded .json files
echo ""
echo "Downloaded effects:"
echo "-------------------"
ls -1 Szmelc-RGB-main/effects/*.json
echo "-------------------"

# Prompt the user to merge with polychromatic/effects
read -p "Do you want to merge the downloaded effects with /home/${USERNAME}/.config/polychromatic/effects? [Y/n]: " answer

if [[ $answer == "Y" || $answer == "y" ]]; then
    # Check if the polychromatic/effects directory exists
    if [ ! -d "/home/${USERNAME}/.config/polychromatic/effects" ]; then
        # Create the directory if it doesn't exist
        mkdir -p /home/${USERNAME}/.config/polychromatic/effects/
    fi

    # Copy the .json files to the polychromatic/effects directory
    rsync -av --progress Szmelc-RGB-main/effects/*.json /home/${USERNAME}/.config/polychromatic/effects/

    # Check for conflicts
    conflicts=$(rsync -avn Szmelc-RGB-main/effects/*.json /home/${USERNAME}/.config/polychromatic/effects/ | grep "^>")

    if [ -n "$conflicts" ]; then
        # Prompt the user to resolve conflicts
        read -p "There are conflicts with existing files. Do you want to overwrite them? [Y/n]: " overwrite

        if [[ $overwrite == "Y" || $overwrite == "y" ]]; then
            rsync -av Szmelc-RGB-main/effects/*.json /home/${USERNAME}/.config/polychromatic/effects/
        else
            echo "Aborting merge..."
        fi
    fi
fi

# Clean up downloaded files
rm Szmelc-RGB.zip
rm -r Szmelc-RGB-main

clear && sleep 1
ls /home/${USERNAME}/.config/polychromatic/effects/ | lolcat > logs/loaded.txt
echo "" && echo "Loaded effects logged into logs/loaded.txt" && echo "" && sleep 1 && echo "Loaded Effects" && echo ""
cat logs/loaded.txt && echo ""
