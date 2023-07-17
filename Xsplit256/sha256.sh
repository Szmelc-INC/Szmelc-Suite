#!/bin/bash

# Get the selected file name from user input
ls && echo "" && sleep 1
echo "Enter the name of the file you want to compute the SHA256 hash for:"
read filename

# Compute the hash
hash=$(sha256sum "$filename" | cut -d ' ' -f 1)

# Check if a log file with the same name already exists
logname="hash/sha256-$filename-1.txt"
count=1
while [ -e "$logname" ]
do
  ((count++))
  logname="hash/sha256-$filename-$count.txt"
done

# Write the hash to the log file
echo "SHA256 hash for $filename: $hash" > "$logname"
echo "Log file saved as $logname"

sleep 1
echo "" && echo " HASH DIR " && echo "" && ls hash && echo ""
