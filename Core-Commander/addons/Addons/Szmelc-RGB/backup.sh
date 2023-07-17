#!/bin/bash

# Set the name of the archive file
archive_name="effects.tar.gz"

# Set the path to the directory to be backed up
backup_dir="/home/${USER}/.config/polychromatic/effects"

# Set the path to the directory where the archive file will be saved
archive_dir="$(dirname "$(realpath "$0")")"

# Create the archive file
tar -czf "${archive_dir}/${archive_name}" -C "${backup_dir}" .

# Print a message indicating that the backup was successful
clear && echo ""
echo " Backup of ${backup_dir} completed successfully."
echo " Archive file saved to ${archive_dir}/${archive_name}." && echo ""

sleep 2
bash exec.sh

