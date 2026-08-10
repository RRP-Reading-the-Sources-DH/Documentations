import csv
import json
from pathlib import Path

# --- Configuration ---
MANIFEST_PATH = "manifest.json"   # path to the downloaded IIIF manifest
OUTPUT_CSV = "iiif_image_urls_range_gal.csv"

START_INDEX = 1
END_INDEX = 50

# --- Load manifest from file ---
manifest_path = Path(MANIFEST_PATH)

if not manifest_path.exists():
    raise SystemExit(f"Manifest file not found: {manifest_path}")

try:
    with open(manifest_path, "r", encoding="utf-8") as f:
        manifest = json.load(f)
except json.JSONDecodeError:
    raise SystemExit("Error: manifest.json is not valid JSON.")
except OSError as e:
    raise SystemExit(f"Error reading manifest file: {e}")

# --- Extract image URLs ---
rows = []
counter = 1

sequences = manifest.get("sequences", [])
if not sequences:
    raise SystemExit("Error: No sequences found in manifest.")

canvases = sequences[0].get("canvases", [])
if not canvases:
    raise SystemExit("Error: No canvases found in manifest.")

for canvas in canvases:
    for image_entry in canvas.get("images", []):
        image_url = image_entry.get("resource", {}).get("@id")

        if image_url:
            if START_INDEX <= counter <= END_INDEX:
                rows.append([counter, image_url])
            counter += 1

        if counter > END_INDEX:
            break
    if counter > END_INDEX:
        break

# --- Write CSV ---
if rows:
    with open(OUTPUT_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["index", "image_url"])
        writer.writerows(rows)

    print(f"Saved {len(rows)} URLs (images {START_INDEX}-{END_INDEX}) to {OUTPUT_CSV}")
else:
    print("No images found in the specified range.")
