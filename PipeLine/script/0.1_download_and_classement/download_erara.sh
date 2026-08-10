#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start_index> <end_index>"
    exit 1
fi

# Define the base URL (which is fixed) and get the index values from command line arguments
base_url="https://www.e-rara.ch/download/webcache/1000/"
start_index=$1
end_index=$2

# Loop through the range of URLs and download each file
for ((i=start_index; i<=end_index; i++)); do
    url="${base_url}${i}"
    echo "Downloading: $url"
    
    # Use wget to download the file
    wget "$url"
    
    # Rename the downloaded file to have the .png extension
    downloaded_file=$(basename "$url")
    mv "$downloaded_file" "${downloaded_file}.jpeg"
done

echo "Download and renaming completed!"

#Use of the script 
# bash run_script.sh $1 $2 ; 
# bash run_script.sh 2012883 20128980 
# where $1 = start_index = page one of your document ;$2 = end_index = end page of your document
# working for this format of url link : https://www.e-rara.ch/download/webcache/1000/2012883

