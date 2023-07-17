#!/bin/bash
# Szmelc dependency installer using APT

clear
echo ""
cat "$(dirname "$0")/title.txt" && sleep 1
echo "" && sleep 1 && echo " Fetching packages list from packages.txt" && echo "" && sleep 1

# Read package list from file
packages_file="$(dirname "$0")/packages.txt"
if [ ! -f "$packages_file" ]; then
  echo "Package list not found at '$packages_file', exiting..."
  exit 1
fi
packages=($(<"$packages_file"))

# Filter out invalid packages
valid_packages=()
for package in "${packages[@]}"; do
  if sudo apt-cache show "$package" > /dev/null 2>&1; then
    valid_packages+=("$package")
  else
    echo "Package '$package' not found, skipping..."
  fi
done

if [ ${#valid_packages[@]} -eq 0 ]; then
  echo "No valid packages found to install, exiting..."
  exit 1
fi

echo "" && echo "Packages to be installed:" && echo ""
for package in "${valid_packages[@]}"
do
    echo "- $package"
done
echo ""

read -p "Do you want to proceed with installation? [Y/n] " choice
case "$choice" in
    n|N ) echo " ERROR: Cancelled.." && exit ;;
    * ) ;;
esac

echo ""
echo "Please give a moment for APT to install packages"
echo ""

# Create logs directory if it doesn't exist
logs_dir="$(dirname "$0")/logs"
mkdir -p "$logs_dir"

# Find the highest numbered log file and increment it
log_file="$logs_dir/log_1.txt"
if [ -n "$(find "$logs_dir" -maxdepth 1 -type f -name "log_*.txt")" ]; then
  latest_num=0
  for f in "$logs_dir"/log_*.txt; do
    num=$(echo "$f" | sed 's/.*log_\([0-9]\+\)\.txt/\1/')
    if [ $num -gt $latest_num ]; then
      latest_num=$num
    fi
  done
  next_num=$((latest_num + 1))
  log_file="$logs_dir/log_$next_num.txt"
fi

# Install packages with auto-yes flag and log output to log file
sudo apt-get install -y --ignore-missing "${valid_packages[@]}" > "$log_file" 2>&1

echo ""
echo " [Success!]"
echo "~ Output log saved into logs directory!"
echo ""
sleep 1 && bash exec.sh
