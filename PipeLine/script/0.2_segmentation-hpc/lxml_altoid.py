import glob
from lxml import etree

folder_path = "content/image/*.xml"

ALTO_NS = "http://www.loc.gov/standards/alto/ns-v4#"
NSMAP = {"alto": ALTO_NS}

# Preserve formatting when writing
parser = etree.XMLParser(remove_blank_text=False)

for file_path in glob.glob(folder_path):
    try:
        tree = etree.parse(file_path, parser)
        root = tree.getroot()

        block_counter = 0
        line_counter = 0

        # Renumber TextBlock
        for block in root.xpath(".//alto:TextBlock", namespaces=NSMAP):
            block_counter += 1
            block.set("ID", f"block_{block_counter}")

        # Renumber TextLine
        for line in root.xpath(".//alto:TextLine", namespaces=NSMAP):
            line_counter += 1
            line.set("ID", f"line_{line_counter}")

        # Write back with pretty formatting preserved
        tree.write(
            file_path,
            encoding="utf-8",
            xml_declaration=True,
            pretty_print=True
        )

        print(
            f"Updated {block_counter} TextBlock(s) and "
            f"{line_counter} TextLine(s) in: {file_path}"
        )

    except Exception as e:
        print(f"Skipped {file_path}: {e}")