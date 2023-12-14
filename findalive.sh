#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 subnet_list_file"
    exit 1
fi

subnet_file=$1
output_file="aliveips.txt"

# Check if fping is installed
if ! command -v fping &> /dev/null; then
    echo "Error: fping is not installed. Please install it and try again."
    exit 1
fi

# Check if the subnet file exists
if [ ! -f "$subnet_file" ]; then
    echo "Error: Subnet file '$subnet_file' not found."
    exit 1
fi

# Read each subnet from the file and use fping to find alive hosts
while IFS= read -r subnet; do
    echo "Scanning subnet: $subnet"
    fping -g "$subnet" -a >> "$output_file"
done < "$subnet_file"

echo "Alive hosts saved to $output_file"
