#!/bin/bash

#SBATCH --partition=debug-cpu 
#SBATCH --time=00:05:00
#SBATCH --mem=3G
#SBATCH --output=yaltaiseg0-out.%j 

#on utilise un environnement virtuel installé selon la méthode "uv" dans le serveur il n'est donc plsu nécessaire de charger des modules. 

# PYTHON VIRTUAL ENVIRONMENT
source ~/p3.12-venv/bin/activate

# PAGE SEGMENTATION WITH YALTAI-KRAKEN 
yaltai kraken --verbose  -I "content/image/*.jpeg" --alto --suffix ".xml" segment --yolo Layout-16th-Print-Lat.pt
#--raise-on-error
# ALTO XML POST-PROCESSING
# Normalize and fix ALTO file endings (ensure proper </alto> closing tag)
python segmentation-hpc/debug_alto.py

# Update <FileName> field to match the corresponding image filename (.jpg)
python segmentation-hpc/change_xml_file_name2.py

# Rename label "default" to "DefaultLine" for schema consistency
python segmentation-hpc/change_defaultline.py

# add id for BlockZone and textLine
python segmentation-hpc/lxml_altoid.py

# ARCHIVING RESULTS
# Create a ZIP archive containing all segmented ALTO XML files
zip -r altos_segmented.zip content/image/*xml

# ça a fonctionné le 11.02.26, le probleme c'est la qualités des images, si c'est trop penché le script fonctionne pas
# il utilise toute la mémoire dispo pour segmenter en il crache. 
#sacct --format JobID,State,MaxRSS verifier la config
# segmente 1 image en 30 seconde avec 1 600 000 K donc 1.6GB  