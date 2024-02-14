#!/bin/bash

# Define timeout value (in seconds)
TIMEOUT=2

# Check if the user has provided a file name
if [ -z "$1" ]; then
    # If no file is provided, look for a file called "workers" in the same directory
    FILE="workers"
    if [ ! -f "$FILE" ]; then
        echo "Usage: $0 <file>"
        echo "Or $FILE file not found in the current directory."
        exit 1
    fi
else
    FILE="$1"
fi

# Read each line (IP address) from the file
while IFS= read -r ip_address; do
    # Attempt to add SSH key to the remote host with timeout
    timeout $TIMEOUT ssh-copy-id -i ~/.ssh/id_rsa.pub "$ip_address"
done < "$FILE"
