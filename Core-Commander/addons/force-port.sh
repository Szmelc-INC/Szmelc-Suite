#!/bin/bash

# Define the directory to search
dir="Addons"

# Search for exec.sh and main.sh and store the results in an array
files=( $(find "$dir" -name "exec.sh" -o -name "main.sh") )

# If no files are found, exit
if [[ ${#files[@]} -eq 0 ]]; then
    echo "No files found."
    exit 0
fi

# Print the list of files found
echo "The following files were found:"
for file in "${files[@]}"; do
    echo "  $file"
done

# Prompt the user to proceed with the renaming
read -p "Do you want to rename these files? (Y/n) " choice
if [[ $choice =~ ^[Yy]$ ]]; then
    # Rename all exec.sh and main.sh to init.sh
    for file in "${files[@]}"; do
        mv "$file" "${file%/*}/init.sh"
    done
    echo "Files renamed successfully."
else
    echo "Aborted."
fi

echo "$file" > logs/forceported.txt
exit 0
