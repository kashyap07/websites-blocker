#!/bin/zsh

# -----------------------------------------------------------------------------
# Author: Suhas Kashyap
#
# This script blocks/unblocks websites specified in "websites.txt" file.
# Each line in "websites.txt" should contain one website to block.
# It should include the subdomain and TLD (e.g., www.example.com).
# The script toggles between blocking and unblocking each time it is run.
# Use chmod +x focus.sh to make the script executable.
#
# Additional Notes:
# To make this script accessible from anywhere, symlink it to /usr/local/bin.
# sudo ln -s $PWD/focus.sh /usr/local/bin/focus
# make sure to modify the websites.txt path in the script.
# To run the script, type "focus" in the terminal.
#
# Usage: sudo focus
# -----------------------------------------------------------------------------

# Hosts file path (Unix-based systems)
hosts_path="/etc/hosts"

# Absolute path to websites.txt
websites_file="/Users/path/to/directory/websites.txt"

# Redirect to local host
redirect="127.0.0.1"

# Read websites from a file
websites_to_block=()
while IFS= read -r line || [ -n "$line" ]; do
    websites_to_block+=("$line")
done < "$websites_file"

block_websites() {
    echo "# focus mode - $(date)" | sudo tee -a "$hosts_path" > /dev/null
    for website in "${websites_to_block[@]}"; do
        if ! grep -q "$website" "$hosts_path"; then
            echo "$redirect $website" | sudo tee -a "$hosts_path" > /dev/null
        fi
    done
    echo "Websites blocked."
}

unblock_websites() {
    for website in "${websites_to_block[@]}"; do
        sudo sed -i ".bak" "/$website/d" "$hosts_path"
    done
    sudo sed -i ".bak" "/# focus mode /d" "$hosts_path"
    echo "Websites unblocked."
}

# Check if any of the websites are already blocked
are_websites_blocked=0
for website in "${websites_to_block[@]}"; do
    if grep -q "$website" "$hosts_path"; then
        are_websites_blocked=1
        break
    fi
done

if (( are_websites_blocked )); then
    unblock_websites
else
    block_websites
fi
