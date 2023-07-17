#!/bin/bash

# Get the script's directory as the main directory
MAIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to execute the selected .sh or .py file
function execute_module() {
  selected_module="$1"
  module_folder=$(dirname "$selected_module")
  module_name=$(basename "$module_folder")
  module_file=$(basename "$selected_module")
  cd "$module_folder"
  if [[ "$module_file" == *.sh ]]; then
    bash "$module_file"
  elif [[ "$module_file" == *.py ]]; then
    python3 "$module_file"
  else
    zenity --error --text="Invalid file type!"
    exit 1
  fi
}

# Generate module list based on .sh and .py files in the main directory
module_list=()
IFS=$'\n'
for file in $(find "$MAIN_DIR" -type f \( -name "*.sh" -o -name "*.py" \) ! -name "exec.sh" ); do
  module_folder=$(dirname "$file")
  module_name=$(basename "$module_folder")
  module_list+=("[$module_name] $(basename "$file")")
done
unset IFS

# If no modules are found, display an error message
if [ ${#module_list[@]} -eq 0 ]; then
  zenity --error --text="No module files found in the main directory!"
  exit 1
fi

# Use Zenity to create a list dialog with the module list
selected_module=$(zenity --list --title="$MAIN_DIR" --text="Select a module:" --column="Directory Name" "${module_list[@]}" --height 400 --width 250)

# Check if a module is selected and call the function to execute it
if [ -n "$selected_module" ]; then
  module_name=$(echo "$selected_module" | sed -E 's/\[([^]]+)\].*/\1/')
  module_file=$(echo "$selected_module" | sed -E 's/.*\] (.*)/\1/')
  execute_module "$MAIN_DIR/$module_name/$module_file"
fi
