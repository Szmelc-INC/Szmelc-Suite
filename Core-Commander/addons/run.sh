#!/bin/bash

# define menu options as an array
options=($(find Addons/* -maxdepth 0 -type d -printf '%f\n' | awk '{print NR, $0}'))

# define function for executing code for each option
function execute_option {
  addon_dir="Addons/${options[$1*2-1]}"
  addon_name=${options[$1*2]}

  echo "Executing $addon_name"

  cd "$addon_dir" && bash init.sh
}

# show dialog menu and capture selected option
selected=$(dialog --backtitle  "Addon Runner" --title "[Run Addon] ~ [init.sh]" --menu "\nUse the UP/DOWN arrow keys to navigate\n\n" 20 40 10 "${options[@]}" 2>&1 >/dev/tty)

# execute code for selected option
execute_option $selected
sleep 1 && ls && cd "$addon_dir" && bash init.sh

# PUT CORE GUI CODE IN CORE.SH
