#!/bin/bash
# [Get Addons BULK]
# [Get Addons BULK]

# Set the default download directory and target directory
SCRIPT_DIR="$( cd "$( dirname "${0}" )" &> /dev/null && pwd )"

download_dir="tmp"
target_dir="Addons"

# Load repositories from repos.json file
repositories=($(jq -r '.[]' config/repos.json))

# Create the target directory if it doesn't exist
mkdir -p "$target_dir"

# Create a dialog box with three options: "Download", "Cancel", and "List"
dialog --backtitle "Get Addons BULK" --menu "Select an option:" 0 0 0 \
    "Download" "Download all repositories" \
    "Cancel" "Cancel download" \
    "List" "List repository URLs" \
    2> /tmp/option

# Check the exit status of the dialog box
case $? in
    0)
        # Read the selected option from the temporary file
        option=$(cat /tmp/option)
        # Perform the appropriate action based on the selected option
        case $option in
            "Download")
                for repo_url in "${repositories[@]}"; do
                    # Extract the repository name from the URL
                    repo_name=$(basename "$repo_url")

                    # Check if the repository already exists in the target directory
                    if [ -d "$target_dir/$repo_name" ]; then
                        # If it does, forcefully remove it
                        rm -rf "$target_dir/$repo_name"
                    fi

                    # Clone the repository into the target directory, forcefully skipping username/password prompts
                    GIT_TERMINAL_PROMPT=0 git clone "$repo_url" "$target_dir/$repo_name"

                    # Print success message
                    echo "Successfully cloned/update repository $repo_name into $target_dir"
                done

                # Restart the script to show the dialog box again
                echo "Cloning/Updating of repositories from repos.json completed."
                cd "${SCRIPT_DIR}" && sleep 1 && bash "${0}"
                ;;
            "Cancel")
                # Print cancellation message and exit
                echo "Download cancelled."
                cd "${SCRIPT_DIR}" && sleep 1 && bash main.sh
                ;;
            "List")
                # Display the list of repository URLs
                dialog --backtitle "Addon Repo Links" --textbox config/repos.json 20 75
                ;;
        esac
        ;;
    *)
        # If the user pressed the escape key or closed the dialog box, print a message and exit
        echo "Download cancelled."
        cd "${SCRIPT_DIR}" && sleep 1 && bash "${0}"
        ;;
esac
