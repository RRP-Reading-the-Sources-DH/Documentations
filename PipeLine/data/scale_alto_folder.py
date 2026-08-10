"""
scale_alto_folder.py

Le document e-rara peuvent ne pas être téléchargé dans leur format originale, le script suivant permet de corriger d'éventuel problème d'échelle. 

Multiplie tous les attributs numériques des fichiers XML-ALTO d'un dossier par 2,3
et arrondit les résultats à l'entier le plus proche.

Par défaut traite le dossier "doc_1" et écrit les résultats dans "doc_1_scaled".

Usage :
  python scale_alto_folder.py                         # doc_1 → doc_1_scaled
  python scale_alto_folder.py mon_dossier             # mon_dossier → mon_dossier_scaled
  python scale_alto_folder.py entree/ sortie/         # dossiers personnalisés
"""

import re
import sys
import os
from pathlib import Path

# remettre à l'échelle le document en calculant la différence entre l'image téléchargée et  la taille du fichier original. 
# la valeur de SCALE est égale à x, si fichier_téléchargé .  x =  fichier_original. 
SCALE = 2.57

SKIP_ATTRS = {"WC", "CC", "PC", "PHYSICAL_IMG_NR", "ID", "TAGREFS",
              "version", "encoding", "schemaLocation", "xmlns", "xsi"}


def scale_number(value: str) -> str:
    return str(round(float(value) * SCALE))


def scale_list(coords_str: str) -> str:
    numbers = coords_str.strip().split()
    return " ".join(scale_number(n) for n in numbers)


def process_attribute(attr_name: str, attr_value: str) -> str:
    if attr_name in SKIP_ATTRS:
        return attr_value
    if attr_name in ("POINTS", "BASELINE"):
        return scale_list(attr_value)
    if attr_name in ("HPOS", "VPOS", "WIDTH", "HEIGHT", "ROTATION"):
        try:
            return scale_number(attr_value)
        except ValueError:
            return attr_value
    # Tout attribut dont la valeur est un nombre pur
    if re.fullmatch(r"-?\d+(\.\d+)?", attr_value.strip()):
        try:
            return scale_number(attr_value)
        except ValueError:
            return attr_value
    return attr_value


def process_xml(content: str) -> str:
    pattern = re.compile(r'(\w+)=(["\'])([^"\']+)\2')

    def replace_attr(match):
        name, quote, value = match.group(1), match.group(2), match.group(3)
        return f'{name}={quote}{process_attribute(name, value)}{quote}'

    return pattern.sub(replace_attr, content)


def process_folder(input_dir: Path, output_dir: Path):
    # Trouver tous les fichiers XML (récursivement)
    xml_files = sorted(input_dir.rglob("*.xml"))

    if not xml_files:
        print(f"⚠  Aucun fichier .xml trouvé dans : {input_dir}")
        return

    print(f"📂 Dossier source  : {input_dir}")
    print(f"📂 Dossier sortie  : {output_dir}")
    print(f"⚙  Facteur         : x{SCALE}")
    print(f"📄 Fichiers trouvés : {len(xml_files)}\n")

    ok = 0
    errors = 0

    for xml_path in xml_files:
        # Reconstruire le chemin relatif pour conserver l'arborescence
        relative = xml_path.relative_to(input_dir)
        out_path = output_dir / relative
        out_path.parent.mkdir(parents=True, exist_ok=True)

        try:
            content = xml_path.read_text(encoding="utf-8")
            scaled = process_xml(content)
            out_path.write_text(scaled, encoding="utf-8")
            print(f"  ✓  {relative}")
            ok += 1
        except Exception as e:
            print(f"  ✗  {relative}  →  {e}")
            errors += 1

    print(f"\n{'='*50}")
    print(f"Terminé : {ok} fichier(s) traité(s), {errors} erreur(s).")
    print(f"Résultats dans : {output_dir.resolve()}")


def main():
    args = sys.argv[1:]

    if len(args) == 0:
        input_dir = Path("doc_1")
        output_dir = Path("doc_1_scaled")
    elif len(args) == 1:
        input_dir = Path(args[0])
        output_dir = Path(args[0].rstrip("/\\") + "_scaled")
    elif len(args) == 2:
        input_dir = Path(args[0])
        output_dir = Path(args[1])
    else:
        print("Usage : python scale_alto_folder.py [dossier_entree] [dossier_sortie]")
        sys.exit(1)

    if not input_dir.exists():
        print(f"❌ Dossier introuvable : {input_dir}")
        sys.exit(1)

    process_folder(input_dir, output_dir)


if __name__ == "__main__":
    main()
