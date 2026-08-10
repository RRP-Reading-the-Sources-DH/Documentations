import requests
import csv

# --- Configuration ---
MANIFEST_URL = "./manifest.json" # changer l'url en fonction du document 
OUTPUT_CSV = "iiif_image_urls_range_gal.csv"
START_INDEX = 1
END_INDEX = 50

# --- Headers to bypass 403 ---
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
                  "(KHTML, like Gecko) Chrome/117.0 Safari/537.36"
}

# --- Fetch manifest ---
try:
    response = requests.get(MANIFEST_URL, headers=HEADERS)
    response.raise_for_status()  # raises HTTPError for bad status codes
    manifest = response.json()
except requests.exceptions.RequestException as e:
    raise SystemExit(f"Error fetching manifest: {e}")
except ValueError:
    raise SystemExit("Error: Response is not valid JSON. Check the URL.")

# --- Extract image URLs ---
rows = []
counter = 1  # counts all images in the manifest

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
