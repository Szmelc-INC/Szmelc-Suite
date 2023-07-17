#!/bin/bash

# Define the path to the 'Addons' folder
ADDONS_FOLDER="./Addons"

# Function to execute the selected module
function execute_module() {
  selected_module="$1"
  module_dir="$(dirname "$selected_module")"
  module_file="$(basename "$selected_module")"
  cd "$module_dir" && bash "$module_file"
}

# Generate module list based on exec.sh files in Addons folder
module_list=()
IFS=$'\n'
for file in $(find "$ADDONS_FOLDER" -type f -name "init.sh"); do
  module_folder=$(basename "$(dirname "$file")")
  module_name=$(basename "$file")
  module_list+=("$file" "[$module_folder] ${module_name##*/}")
done
unset IFS

# If no modules are found, display an error message
if [ ${#module_list[@]} -eq 0 ]; then
  dialog --title "Error" --msgbox "No 'init.sh' files found in Addons folder!" 0 0
  exit 1
fi

# Use dialog to create a list dialog with the module list
selected_module=$(dialog --clear --stdout --backtitle "Commander / Runner" --title "Module List" --menu "Select a module:" 0 0 0 "${module_list[@]}")

# Check if a module is selected and call the function to execute it
if [ -n "$selected_module" ]; then
  execute_module "$selected_module"
fi
ls && bash core/core.sh
