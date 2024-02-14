#!/bin/bash

# Check if the user has provided a file name
if [ -z "$1" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

# Check if the provided file exists
if [ ! -f "$1" ]; then
    echo "File not found: $1"
    exit 1
fi

# Read each line (IP address) from the file
while IFS= read -r ip_address; do
    # Attempt to add SSH key to the remote host
    ssh-copy-id -i ~/.ssh/id_rsa.pub "$ip_address"
done < "$1"
