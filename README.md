# websites-blocker
v1, CLI for now
written using GitHub Copilot for the most part lol

## What is it
This script blocks/unblocks websites specified in "websites.txt" file.
Each line in "websites.txt" should contain one website to block.
It should include the subdomain and TLD (e.g., www.example.com).
The script toggles between blocking and unblocking each time it is run.
Use chmod +x focus.sh to make the script executable.

## Additional Notes:
To make this script accessible from anywhere, symlink it to /usr/local/bin.
sudo ln -s $PWD/focus.sh /usr/local/bin/focus
make sure to modify the websites.txt path in the script.
To run the script, type "focus" in the terminal.

## Usage
sudo focus
