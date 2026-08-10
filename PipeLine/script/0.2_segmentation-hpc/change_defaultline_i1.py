import glob
import re

folder_path = "content/image_1/*.xml"
# we are using regex so it works even on corrupted xml 
pattern = re.compile(
    r'(<OtherTag\s+[^>]*DESCRIPTION="line type"[^>]*ID="LINE_TYPE_1"[^>]*TYPE="type"[^>]*LABEL=")default(")',
    re.IGNORECASE
)

for file_path in glob.glob(folder_path):
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            content = f.read()

        new_content, count = pattern.subn(r'\1DefaultLine\2', content)

        if count > 0:
            with open(file_path, "w", encoding="utf-8") as f:
                f.write(new_content)
            print(f"Updated {count} tag(s) in: {file_path}")

    except Exception as e:
        print(f"Skipped {file_path}: {e}")
