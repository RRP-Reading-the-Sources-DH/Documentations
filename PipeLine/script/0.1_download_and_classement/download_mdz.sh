#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <identifier> <start_index> <end_index>"
    exit 1
fi

# Get the identifier and index values from command line arguments
base_url="https://api.digitale-sammlungen.de/iiif/image/v2/$1"
start_index=$2
end_index=$3

# Loop through the range of URLs and download each file
for ((i=start_index; i<=end_index; i++)); do
    index=$(printf "%05d" $i)  # Pad the index with leading zeros
    url="${base_url}${index}/full/full/0/default.jpg"
    echo "Downloading: $url"

    # Use wget to download the file
    wget "$url" -O "${1}${index}.jpg"
done

echo "Download and renaming completed!"

#Use of the script 
# bash run_script.sh $1 $2 $3
# bash run_script.sh bsb11059254_ 1 658 
# were $1 = base url = bsb11059254_ ; $2 = start_index = page one of your document ;$3 = end_index = end page of your document
# working for this format of url link : https://api.digitale-sammlungen.de/iiif/image/v2/bsb11059254_00008/full/full/0/default.jpg
# \!| do not forget the underscore _ after number of the base url = bsb11059254_