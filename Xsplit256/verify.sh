#!/bin/bash

#!/bin/bash

# Loop over each file
for file in sha256--1.txt sha256--2.txt; do

  # Read the contents of the file
  file_content=$(cat "$file")

  # Remove all text and whitespace shorter than 30 characters
  cleaned_content=$(echo "$file_content" | grep -oE '[[:alnum:]]{30,}' | tr -d '[:space:]')

  # Write the cleaned content back to the file
  echo "$cleaned_content" > "$file"

done


# Calculate the SHA256 hash of sha256--1.txt
hash1=$(sha256sum hash/sha256--1.txt | awk '{ print $1 }')

# Calculate the SHA256 hash of sha256--2.txt
hash2=$(sha256sum hash/sha256--2.txt | awk '{ print $1 }')

# Strip any additional text from the hashes
hash1=$(echo "$hash1" | grep -Eo '[[:xdigit:]]{64}')
hash2=$(echo "$hash2" | grep -Eo '[[:xdigit:]]{64}')

# Compare the two hashes
if [ "$hash1" == "$hash2" ]
then
  beep -f 666 -l 120 && beep -f 666 -l 100 && beep -f 666 -l 100 && beep -f 666 -l 100
  echo "MATCH" | figlet > hash/tmp.txt
  dialog --prgbox  "cat hash/tmp.txt"  10 35
  rm hash
  # Run example code if they match
  # example_code.sh
else
  beep && beep && beep && beep -f 300 -D 50 -l 500 && beep -f 350 -D 50 -l 420
  echo "ERROR" | figlet > hash/tmp.txt
  dialog --prgbox  "cat hash/tmp.txt"  10 35
  beep && beep && beep && beep -f 300 -D 50 -l 500 && beep -f 350 -D 50 -l 420
  #rm sha256--1.txt sha256--2.txt tmp.txt
fi
