#!/bin/bash

# Check if the correct number of arguments are provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <filename.tar.gz> <key>"
    exit 1
fi

# Extract the arguments
file="$1"
key="$2"

# Check if the file exists
if [[ ! -f "$file" ]]; then
    echo "Error: File $file does not exist."
    exit 1
fi

# Encrypt the file using tar and openssl with the given key
encrypted_file="${file}.enc"
tar cz "$file" | openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -pass pass:"$key" -out "$encrypted_file"

# Check if encryption was successful
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to encrypt $file."
    exit 1
fi

echo "File $file encrypted as $encrypted_file with key \"$key\"."

# Decrypt the file using openssl and tar with the given key
decrypted_file="${file}.dec"
openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -pass pass:"$key" -in "$encrypted_file" | dd of="$decrypted_file" bs=1M conv=notrunc

# Check if decryption was successful
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to decrypt $encrypted_file."
    exit 1
fi

echo "File $encrypted_file decrypted as $decrypted_file with key \"$key\"."

# Remove all .tar.gz & .dec files
rm -f *.tar.gz
rm -f *.tar.gz.dec

# Clear terminal screen
clear
