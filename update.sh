#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq

BING_URL="https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US"

RESPONSE=$(curl -s $BING_URL)
IMAGE_URL_VAL=$(echo "$RESPONSE" | jq -r '.images[0].url')
IMAGE_URL="https://www.bing.com$IMAGE_URL_VAL"

echo $IMAGE_URL


