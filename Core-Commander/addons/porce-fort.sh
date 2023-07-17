#!/bin/bash

# Define search terms
SEARCH_TERMS=("main.sh" "exec.sh")

# Define the directory to search in
SEARCH_DIR="Addons"

# Find all files containing search terms and store the result in a variable
FILES=$(grep -rl ${SEARCH_TERMS[@]} ${SEARCH_DIR}/*.sh ${SEARCH_DIR}/**/*.sh)

# Print list of found files
echo "The following files contain the search terms:"
echo "${FILES}"

# Prompt user to proceed with replacement
read -p "Do you want to replace the search terms with 'init.sh'? (Y/n)" choice
case "$choice" in
  y|Y )
    # Replace search terms with 'Porce Fort' in all files found
    sed -i 's/main.sh/init.sh/g' ${FILES}
    sed -i 's/exec.sh/init.sh/g' ${FILES}
    echo "Search terms have been replaced with 'Porce Fort'"
    ;;
  n|N )
    echo "No changes made"
    ;;
  * )
    echo "Invalid choice. No changes made."
    ;;
esac
