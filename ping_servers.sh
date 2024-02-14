#!/bin/bash

# Define timeout value for ping (in seconds)
PING_TIMEOUT=2

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
    # Ping the remote host with timeout
    ping -c 1 -W $PING_TIMEOUT "$ip_address" > /dev/null 2>&1

    # Check the exit code of ping
    if [ $? -eq 0 ]; then
        echo "$ip_address is reachable"
    else
        echo "$ip_address is unreachable"
    fi
done < "$1"
