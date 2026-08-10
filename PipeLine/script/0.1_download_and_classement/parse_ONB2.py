import requests
import csv

MANIFEST_URL = "https://api.onb.ac.at/iiif/presentation/v3/manifest/109892B3"
OUTPUT_CSV = "iiif_image_urls_range2.csv"

# Define the range you want
START_INDEX = 1   # e.g., 1
END_INDEX = 182   # e.g., 50

# Fetch manifest from the web
manifest = requests.get(MANIFEST_URL).json()

rows = []
counter = 1  # counts all images in the manifest

for canvas in manifest.get("items", []):
    for annotation_page in canvas.get("items", []):
        for annotation in annotation_page.get("items", []):
            image_url = annotation.get("body", {}).get("id")
            if image_url:
                if START_INDEX <= counter <= END_INDEX:
                    rows.append([counter, image_url])
                counter += 1
            if counter > END_INDEX:
                break
        if counter > END_INDEX:
            break
    if counter > END_INDEX:
        break

# Write CSV
with open(OUTPUT_CSV, "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["index", "image_url"])
    writer.writerows(rows)

print(f"Saved {len(rows)} URLs (images {START_INDEX}-{END_INDEX}) to {OUTPUT_CSV}")
