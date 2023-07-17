#!/bin/bash
# Szmelc RGB - Razer Chroma Front End for polychromatic-cli

clear
echo "Szmelc RGB" | figlet | lolcat && echo ""
# Get the current user's username
USERNAME=$(whoami)

# Define the directory containing the effect scripts
EFFECTS_DIR="/home/${USERNAME}/.config/polychromatic/effects"

# Get a list of all effect script files in the effects directory
EFFECTS_LIST=$(ls "${EFFECTS_DIR}"/*.json | awk -F/ '{print $NF}' | sed 's/\.json$//' | sort)

# Prompt the user to select an effect script
echo " === === ==="
echo "Select an effect:"
select EFFECT in $EFFECTS_LIST
do
  # If the user selected a valid effect script, execute it
  if [[ -n $EFFECT ]]
  then
    echo "Executing..."
    echo "${EFFECT}" | figlet | lolcat
    polychromatic-cli -o none && polychromatic-cli -e "${EFFECT}"
    break
  fi
done

sleep 1 && clear
bash exec.sh
