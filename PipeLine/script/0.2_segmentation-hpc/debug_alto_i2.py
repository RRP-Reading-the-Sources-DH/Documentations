"""
The end of the ALTO file can be corrupted du to the segmentation work. This script correct the eventual bug appearing on the last line of the alto file. 
"""
import os

FOLDER_PATH = "content/image_2/"  # change this

for file_end in os.listdir(FOLDER_PATH):
    if file_end.lower().endswith(".xml"):
        file_path = os.path.join(FOLDER_PATH, file_end)

        with open(file_path, "r", encoding="utf-8") as f:
            lines = f.readlines()

        if not lines:
            continue  # skip empty files

        # Remove the last line
        lines = lines[:-1]

        # Add the correct closing tag
        lines.append("</alto>\n")

        # Rewrite the file
        with open(file_path, "w", encoding="utf-8") as f:
            f.writelines(lines)

        print(f"Fixed: {file_end}")
