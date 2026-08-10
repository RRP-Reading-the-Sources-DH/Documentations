"""
Normalize tilde-based characters and sequences in the text.

This function handles specific transformations for characters like:
- 'ã' to 'an' or 'am' with various conditions.
- 'ẽ' to 'en' or 'em' with similar patterns.
- 'õ' to 'on' or 'om' depending on following characters.
- 'ũ' to 'un' or 'um', 
- special cases for 'õ' and 'ẽ'. The ocr model changed and propose now special caracter (e.g. Pre-composed 'ẽ' → U+1EBD) add in the script. 

It performs the replacement of tilde-based letters, dealing with optional 
separators (such as '-'), and adjusting the result based on the character 
following the tilde.

Peut-être on devrait mettre - et non ¬ dans la boucle à cause de l'ordre des opérations ?  oui! 

"""
import re
import unicodedata



def replace_tilde(text):
    
    # Normalize to NFC to ensure consistency
    text = unicodedata.normalize("NFC", text)
    # combine lettre ~+ a
    # Replace 'ã' followed by optional '-' and 'd'/'t' with 'an'/'an' preserving 'd'/'t' + I add g for Evãgelium
    text = re.sub(r'ã-?([cdgqsſt])', r'an\1', text)
    # Replace 'ã' followed by optional '-' and any other character with 'am', preserving the character
    text = re.sub(r'ã-?([^\S\r\n<]|.)', lambda m: 'am ' if m.group(1).isspace() else 'am' + m.group(1), text)
    # Replace 'ã' at the end of a line with 'am'
    text = re.sub(r'ã-?$', 'am', text, flags=re.MULTILINE)
    
    # unice character ã
    # Replace 'ã' followed by optional '-' and 'd'/'t' with 'an'/'an' preserving 'd'/'t' + I add g for Evãgelium
    text = re.sub(r'ã-?([cdgqsſt])', r'an\1', text)
    # Replace 'ã' followed by optional '-' and any other character with 'am', preserving the character
    text = re.sub(r'ã-?([^\S\r\n<]|.)', lambda m: 'am ' if m.group(1).isspace() else 'am' + m.group(1), text)
    # Replace 'ã' at the end of a line with 'am'
    text = re.sub(r'ã-?$', 'am', text, flags=re.MULTILINE)
    
     # combine lettre ~+ e
    # Replace 'ẽ' followed by optional '-' and 'd'/'s'/'t' with 'en'/'em' preserving the character
    text = re.sub(r'ẽ-?([dsſt])', r'en\1', text)
    # Replace 'ẽ' followed by optional '-' and any other character with 'em', preserving the character
    text = re.sub(r'ẽ-?([^\S\r\n<]|.)', lambda m: 'em ' if m.group(1).isspace() else 'em' + m.group(1), text)
    # Replace 'ẽ' at the end of a line with 'em'
    text = re.sub(r'ẽ-?$', 'em', text, flags=re.MULTILINE)
    
     # Handle special case for 'ẽ' - replace with 'en'/'em' as necessary
    text = re.sub(r'ẽ-?([dsſt])', r'en\1', text)
    # Replace 'ẽ' followed by optional '-' and any other character with 'em', preserving the character
    text = re.sub(r'ẽ-?([^\S\r\n<]|.)', lambda m: 'em ' if m.group(1).isspace() else 'em' + m.group(1), text)
    # Replace 'ẽ' at the end of a line with 'em'
    text = re.sub(r'ẽ-?$', 'em', text, flags=re.MULTILINE)
    
    # Standalone ĩ (NFC: precomposed)
    text = re.sub(r'\bĩ\b', 'in', text)
    

    # Combine letter ĩ + optional - before m
    text = re.sub(r'ĩ-?([m])', r'im\1', text)
    text = re.sub(r'ĩ-?([cdfgno])', r'in\1', text)
    text = re.sub(r'ĩ-?$', 'in', text, flags=re.MULTILINE)
    # Handle special case for ĩ + optional -
    text = re.sub(r'ĩ-?([m])', r'im\1', text)
    text = re.sub(r'ĩ-?([cdfgno])', r'in\1', text)
    text = re.sub(r'ĩ-?$', 'in', text, flags=re.MULTILINE)
    
    #combine lettre
    # Replace 'õ' followed by optional '-' and 'p'/'b' with 'om'/'om' preserving the character
    text = re.sub(r'õ-?([pbmn])', r'om\1', text)
    # Replace 'õ' followed by optional '-' and any other character with 'on', preserving the character
    text = re.sub(r'õ-?([^pbmn])', r'on\1', text)
    # Replace 'õ' at the end of a line with 'on'
    text = re.sub(r'õ-?$', 'on', text, flags=re.MULTILINE)
    
    #unice character
    # Replace 'õ' followed by optional '-' and 'p'/'b' with 'om'/'om' preserving the character
    text = re.sub(r'õ-?([pbmn])', r'om\1', text)
    # Replace 'õ' followed by optional '-' and any other character with 'on', preserving the character
    text = re.sub(r'õ-?([^pbmn])', r'on\1', text)
    # Replace 'õ' at the end of a line with 'on'
    text = re.sub(r'õ-?$', 'on', text, flags=re.MULTILINE)
    
    # combine lettre ~+ u
    # Replace 'ũ' followed by optional '-' and 't'/'c' with 'un'/'um' preserving the character
    text = re.sub(r'ũ-?([cdt])', r'un\1', text)
    # Replace 'ũ' followed by optional '-' and any other character with 'um', preserving the character
    text = re.sub(r'ũ-?([^\S\r\n<]|.)', lambda m: 'um ' if m.group(1).isspace() else 'um' + m.group(1), text)
    # Replace 'ũ' at the end of a line with 'um'
    text = re.sub(r'ũ-?$', 'um', text, flags=re.MULTILINE)
    
    # unice character ũ
    # Replace 'ũ' followed by optional '-' and 't'/'c' with 'un'/'um' preserving the character
    text = re.sub(r'ũ-?([cdt])', r'un\1', text)
    # Replace 'ũ' followed by optional '-' and any other character with 'um', preserving the character
    text = re.sub(r'ũ-?([^\S\r\n<]|.)', lambda m: 'um ' if m.group(1).isspace() else 'um' + m.group(1), text)
    # Replace 'ũ' at the end of a line with 'um'
    text = re.sub(r'ũ-?$', 'um', text, flags=re.MULTILINE)
    
     # Rule for 'b' followed by '.' or '·'
    text = re.sub(r'b[.·](?!<)', r'bus ', text)  # Replace 'b.' and 'b·' with 'b us ': il faut corriger dans word l'erreur libus =liber
    

    return text
