#!/bin/bash

# Check if the correct number of arguments are provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <filename.tar.gz.enc> <key>"
    exit 1
fi

# Extract the arguments
encrypted_file="$1"
key="$2"

# Check if the file exists
if [[ ! -f "$encrypted_file" ]]; then
    echo "Error: File $encrypted_file does not exist."
    exit 1
fi

# Decrypt the file using openssl with the given key
decrypted_file="${encrypted_file%.enc}.dec"
openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -pass pass:"$key" -in "$encrypted_file" -out "$decrypted_file"

# Check if decryption was successful
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to decrypt $encrypted_file."
    exit 1
fi

# Extract the tar.gz file from the decrypted file

tar xf "$decrypted_file" -C "$(dirname "$decrypted_file")"
# Remove all .tar.gz.enc & .dec files
rm -f *.tar.gz.enc
rm -f *.tar.gz.dec

# Clear terminal screen
clear

echo "File $encrypted_file decrypted as $decrypted_file with key \"$key\"."
