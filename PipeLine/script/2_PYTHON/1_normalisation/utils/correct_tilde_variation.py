import re
    
def  correct_tilde_variation(text):
    # Replace any word containing <letter>am- with the same letter + an-
    # si le mot est interrompu par -, c'est forcément qu'il doit reprendre à la ligne suivant. 
    #par conséquent, il s'agit forcément d'un n qui précéde la coupure. ce scripte corrige le script des tilde, qui provoque cette erreur.
    #faire la même chose pour em et vérifier les autres voyelles avant le breakline
    text = re.sub(r'(\w)am-', r'\1an-', text)
    text = re.sub(r'(\w)em-', r'\1en-', text)   
    
    return text