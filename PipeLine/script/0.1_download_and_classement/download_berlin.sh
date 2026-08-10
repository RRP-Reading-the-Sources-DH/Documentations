#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <identifier> <start_index> <end_index>"
    exit 1
fi

# Get the identifier and index values from command line arguments
base_url="https://content.staatsbibliothek-berlin.de/dc/$1"
start_index=$2
end_index=$3

# Loop through the range of URLs and download each file
for ((i=start_index; i<=end_index; i++)); do
    index=$(printf "%04d" $i)  # Pad the index with leading zeros
    url="${base_url}${index}/full/full/0/default.jpg"
    echo "Downloading: $url"

    # Use wget to download the file
    wget "$url" -O "${1}${index}.jpg"
done

echo "Download and renaming completed!"

#Use of the script 
# bash run_script.sh $1 $2 $3
# bash run_script.sh 66960271X- 1 658 
# were $1 = base url = 66960271X- ; $2 = start_index = page one of your document ;$3 = end_index = end page of your document
# working for this format of url link : https://content.staatsbibliothek-berlin.de/dc/66960271X-0020/full/full/0/default.jpg
# \!| do not forget the hyphen - after number of the base url = 66960271X-