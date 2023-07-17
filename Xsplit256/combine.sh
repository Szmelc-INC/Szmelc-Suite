#!/bin/bash

# Ask user for the file name
filename=$(dialog --inputbox "Enter the file name (include extension) \
(append with split_files/ by default) \
Like [split_files/a.zip]" 15 30 'enter here' 3>&1 1>&2 2>&3)

# Check that an argument was provided
if [ -z "$filename" ]; then
  echo "Usage: $0 [filename]"
  exit 1
fi

# Concatenate the split files into the original file
cat split_files/"$(basename "$filename").part"* > "$filename"

# Compute the hash
hash=$(sha256sum "$filename" | cut -d ' ' -f 1)

# Check if a log file with the same name already exists
logname="hash/sha256-$filename-1.txt"
count=1
while [ -e "$logname" ]
do
  ((count++))
  logname="sha256-$filename-$count.txt"
done

# Write the hash to the log file
echo "SHA256 hash for $filename: $hash" > "$logname"
echo "Log file saved as $logname"

echo "File re-assembled from split files."

# Prompt to delete split files
dialog --yesno "Do you want to delete part files?" 10 30
response=$?
case $response in
   0) rm -f split_files/"$(basename "$filename").part"*
      echo "Split files deleted."
      ;;
   1) echo "Split files not deleted."
      ;;
   255) echo "[ESC] key pressed."
         ;;
esac

echo "Comparing sha256..."
sleep 2
bash verify.sh
