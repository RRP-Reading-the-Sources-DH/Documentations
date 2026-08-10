"""
The script give your xml_file a name corresponding to your image_file so you can use the both files in eScriptorium
"""
import os
import fileinput

for file in os.listdir(os.path.join("content","image")):
    if file.endswith(".xml"):
      with fileinput.FileInput(os.path.join("content","image",file), inplace=True) as f:
        for line in f:
          #modify the path according to the <FileName> of your ALTO file
          print(line.replace('content/image/',''), end='') 
print("All files are corrected!")

