#!/bin/bash
# Szmelc Suite Installer mk-1
# USER SPECIFIC!

clear && echo " Szmelc Suite Install Script " && sleep 1

# Install required dependencies without prompts
pip install google-api-python-client pytesseract pyperclip pandas --break-system-packages
sleep 1 && clear && echo "Script will install some dependencies with APT"
echo "Read GH Documentation to know more"
sudo apt install lolcat figlet toilet dialog python3-dev yt-dlp

# Define the GitHub repository URL and the destination directory
repo_url="https://github.com/GNU-Szmelc/Szmelc-Suite"
destination="$HOME/szmelc"

# Cd to $HOME & create `szmelc` directory
cd && mkdir $destination

# Check if 'git' is installed
if ! command -v git &>/dev/null; then
  echo "Git is not installed. Please install Git and run this script again."
  exit 1
fi

# Clone the GitHub repository into the destination directory
echo "Cloning the repository into $destination..."
git clone $repo_url $destination

# Check if the clone was successful
if [ $? -ne 0 ]; then
  echo "Failed to clone the repository. Exiting."
  exit 1
fi

# Remove the '.git' directory to avoid keeping the entire repository history
rm -rf $destination/.git

# Remove any archive files (e.g., zip, tar.gz, etc.) if they exist
# rm -f $destination.*

echo "Repository is successfully installed in $destination."

# Set executable permissions for files inside 'szmelc/bin'
chmod +x $destination/bin/*

# Append 'source ~/szmelc/szmelcrc' to '.bashrc' in $HOME directory
echo "source ~/szmelc/szmelcrc" >> ~/.bashrc
sleep 1
source ~/.bashrc
sleep 1 && clear
echo "" && echo "You can find list of all commands & features under command szmelc"
exit

