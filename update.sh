#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq

BING_URL="https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US"

RESPONSE=$(curl -s $BING_URL)
IMAGE_URL_VAL=$(echo "$RESPONSE" | jq -r '.images[0].urlbase')
IMAGE_URL="https://www.bing.com$IMAGE_URL_VAL"

IMAGE_FILE="bing_image.jpg"
JSON_FILE="image_data.json"

APPEND_DATA="_UHD.jpg&rf=LaDigue_UHD.jpg&pid=hp"

IMAGE_URL="${IMAGE_URL}${APPEND_DATA}"
echo "Downloading image from $IMAGE_URL"

# Download the image
curl -s -o $IMAGE_FILE $IMAGE_URL

# Calculate the SHA256 hash
IMAGE_HASH=$(sha256sum $IMAGE_FILE | awk '{ print $1 }')

# Save the URL and hash to a JSON file
echo "{\"image_url\": \"$IMAGE_URL\", \"sha256\": \"$IMAGE_HASH\"}" > $JSON_FILE


