#!/bin/bash

# Define timeout value for ping (in seconds)
PING_TIMEOUT=2

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
    # Ping the remote host with timeout
    ping -c 1 -W $PING_TIMEOUT "$ip_address" > /dev/null 2>&1

    # Check the exit code of ping
    if [ $? -eq 0 ]; then
        echo "$ip_address is reachable"
    else
        echo "$ip_address is unreachable"
    fi
done < "$FILE"

