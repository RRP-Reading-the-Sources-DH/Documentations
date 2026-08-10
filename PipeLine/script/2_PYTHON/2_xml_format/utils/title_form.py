"""Normalize certain titles within <fw> tags with <reg type="normalized">."""
import xml.etree.ElementTree as ET

##################### ARETIUS ########################################
"""
def normalize_titles_Aretius(root):
    for fw_tag in root.findall(".//fw[@type='RunningTitleZone']"):
        for reg_tag in fw_tag.findall(".//reg[@type='normalized']"):
            content = reg_tag.text
            if content:
                if content.startswith("CO"):
                    reg_tag.text = "COMMENTARII"
                elif content.startswith("IN"):
                    reg_tag.text = "IN I. EPIST. AD TIMOTH." 

"""
#########################BUCER############################################
"""
def normalize_titles_Bucer(root):
    title_map = {
        "AD": "AD EPHESIOS EPISTOLA",
        "E": "EPISTOLA",
        "D": "D. PAVLI AD EPHESIOS",
        "M": "MARTINI BVCERI",
        "M.": "M. BVCERI COMMENTARIVS",
        "I": "IN EPISTOLAM AD EPHESIOS"
    }
    
    for fw_tag in root.findall(".//fw[@type='RunningTitleZone']"):
        for reg_tag in fw_tag.findall(".//reg[@type='normalized']"):
            content = reg_tag.text
            if content:
                for key, value in title_map.items():
                    if content.startswith(key):
                        reg_tag.text = value
                        break
                else:  # Only runs if no `break` occurs
                    if content.startswith("CA") and len(content) > 5:
                        reg_tag.text = f"CAPVT {content[5:]}"
"""

############################BULLINGER####################################
"""
def normalize_titles_Bullinger(root):
    for fw_tag in root.findall(".//fw[@type='RunningTitleZone']"):
        for reg_tag in fw_tag.findall(".//reg[@type='normalized']"):
            content = reg_tag.text
            if content:
                if content.startswith("AD"):
                    reg_tag.text = "AD TIM. CAP. II."
                elif content.startswith("CO"):
                    reg_tag.text = "COMMENT. IN I. EPIST." 
"""
############################## BUGENHAGEN #################################
""""
def normalize_titles_Bugenhagen(root):
    for fw_tag in root.findall(".//fw[@type='RunningTitleZone']"):
        for reg_tag in fw_tag.findall(".//reg[@type='normalized']"):
            content = reg_tag.text
            if content:
                if content.startswith("ANN"):
                    reg_tag.text = "ANNOT. IOANNIS POMERANI"
                elif content.startswith("IN"):
                    reg_tag.text = "IN EPI. PAV. AD TIM. I." 
"""
######################### Calvin ########################################
"""
def normalize_titles_Calvin(root):
    title_map = {
        "I. TI": "I. TIMOTH.",
        "E": "EPISTOLA",
    }
    
    for fw_tag in root.findall(".//fw[@type='RunningTitleZone']"):
        for reg_tag in fw_tag.findall(".//reg[@type='normalized']"):
            content = reg_tag.text
            if content:
                for key, value in title_map.items():
                    if content.startswith(key):
                        reg_tag.text = value
                        break
                else:  # Only runs if no `break` occurs
                    if content.startswith("CA") and len(content) > 5:
                        reg_tag.text = f"CAPVT {content[5:]}"
"""
######################### HYPERIUS #####################################
"""
def normalize_titles_Hyperius(root):
    title_map = {
        "I":  "IN I. EPIST. D. PAVLI.",
        #"A" : "AD TIMOTHEVM CAP. I.",
    }
    
    for fw_tag in root.findall(".//fw[@type='RunningTitleZone']"):
        for reg_tag in fw_tag.findall(".//reg[@type='normalized']"):
            content = reg_tag.text
            if content:
                for key, value in title_map.items():
                    if content.startswith(key):
                        reg_tag.text = value
                        break
                else:  # Only runs if no `break` occurs
                    if content.startswith("CA") and len(content) > 5:
                        reg_tag.text = f"CAPVT {content[5:]}"
"""                        
#########################LAMBERTUS ###################################
"""
def normalize_titles_Lambertus(root): 
    for fw_tag in root.findall(".//fw[@type='RunningTitleZone']"):
        for reg_tag in fw_tag.findall(".//reg[@type='normalized']"):
            content = reg_tag.text
            if content:
                if content.startswith("AD"):
                    reg_tag.text = "AD I. PAVL. AD TIM."
                elif content.startswith("EP"):
                    reg_tag.text = "EPISTOLA."
                elif content.startswith("CA"):
                    # Check if the first 5 characters match and preserve remaining text
                    reg_tag.text = f"CAPVT {content[5:]}"
"""


# for now all the rule fonction together, but it can change adding file. 