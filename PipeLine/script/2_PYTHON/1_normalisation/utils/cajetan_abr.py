"""
This function replaces characters or combinations of characters 
(e.g., accented letters, ligatures, or deprecated forms) with their 
modern equivalents or simplified forms.

*script for the book for 1500-1530, with complicated abbreviation 

"""

import re

def cajetan_abr(text):
    replacements = {
        r'añ':'ante',
        r'apłic':'apostolic',
        r'chr̃':'christ',
        r'chr̃':'christ',
        r'bñ':'bene',
        r'bñ([a-zA-Z])': r'bene\1',  # Use raw string here too!
        r'dr̃': 'dicitur',
        r'ep̃s':'episcopus',
        r'ep̃m':'episcopum',
        r'ep̃i':'episcopi',
        r'ep̃is':'episcopis',
        r'głi':'glori',
        r'pctõr':'peccator',
        r'pluſq̃':'plusquam',
        r'Pluſq̃':'Plusquam',
        r'quicq̃':'quicquam',
        r'Ꝙ' : 'QVOD',
        r'ꝙ': 'quod',
        r'ẜm':'sum',
        r't̃':'tur',
        r't̃,' :'tur ',
        r'tñ': 'tamen',
        r' .n. ':' enim ',
        r'Ꝙ':'QVOD',
        }

    for pattern, replacement in replacements.items():
        text = re.sub(pattern, replacement, text)

    return text
