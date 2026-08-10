#!/bin/bash

# List of XML files (you can change this to suit your needs)
# Example: xml_files=("file1.xml" "file2.xml")
xml_files=("$@")  # This lets you pass file names as arguments

for file in "${xml_files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "Processing: $file"
        # Use sed to remove all instances of the ᛘ character
        sed -i 's/ᛘ/¬/g' "$file"
    else
        echo "File not found: $file"
    fi
done
