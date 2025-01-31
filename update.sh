#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq

# Make a curl call to a sample API and parse the JSON response
response=$(curl -s https://api.example.com/data)
parsed_value=$(echo "$response" | jq '.key')

echo "Parsed value: $parsed_value"
