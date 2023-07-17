#!/bin/bash
# [Get Addons]
# COMMANDER ULTIMATE 4

# Get the script's directory path
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Load repositories from repos.json file
repositories=($(jq -r '.[]' "${SCRIPT_DIR}/config/repos.json"))

# Set the default download directory and target directory
download_dir="tmp"
target_dir="Addons"

# Create the target directory if it doesn't exist
mkdir -p "$target_dir"

# Generate a list of repository names
repo_list=()
for repo in "${repositories[@]}"; do
    repo_name="${repo##*/}"
    repo_list+=("$repo_name" "")
done

# Use dialog to display a UI for selecting repository names
selected_repo=$(dialog --stdout \
                       --title "Select Repository" \
                       --menu "Select a repository:" 0 0 0 "${repo_list[@]}")

# Check if a repository was selected
if [[ -n "$selected_repo" ]]; then
    # Clone the selected repository into the target directory
    cd "$target_dir"
    git clone "https://github.com/GNU-Szmelc/$selected_repo"
    
    # Print success message
    echo "Successfully cloned repository $selected_repo into $target_dir" && cd "${SCRIPT_DIR}" && sleep 1 && bash "${0}"
else
    # Print error message
    echo "No repository selected. Exiting." && sleep 1 && clear
fi

