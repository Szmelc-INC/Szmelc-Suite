#!/bin/bash

clear
echo ""
echo " Ghost in the Shell.sh "
echo ""
echo " [Create, archive, encrypt] "
echo " Temporary workspaces " 
echo ""

# Prompt user for timeout time in seconds
echo "Enter timeout time (in seconds):"
read timeout_time

# Create CLASSIFIED folder
mkdir CLASSIFIED

# Set timeout
timeout "${timeout_time}s" bash -c 'while true; do sleep 1; done'

# Archive folder to tar.gz
tar -czf CLASSIFIED.tar.gz CLASSIFIED

# Remove CLASSIFIED folder forcefully
rm -rf CLASSIFIED
