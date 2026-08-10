#!/bin/bash

CSV_FILE="iiif_image_urls_range_gal_1.csv"
OUTPUT_DIR="images"

mkdir -p "$OUTPUT_DIR"

tail -n +2 "$CSV_FILE" | while IFS=',' read -r index image_url
do
    # Clean CRLF and quotes
    clean_url=$(echo "$image_url" | tr -d '\r"' )

    # Extract parts from IIIF URL
    base_id=$(echo "$clean_url" | awk -F'/' '{print $(NF-5)}')
    image_id=$(echo "$clean_url" | awk -F'/' '{print $(NF-4)}')

    # Zero-pad index (5 digits)
    padded_index=$(printf "%05d" "$index")

    filename="${base_id}_${image_id}_${padded_index}.jpg"

    echo "Downloading $filename"
    curl -L "$clean_url" -o "$OUTPUT_DIR/$filename"
done

echo "All downloads finished."