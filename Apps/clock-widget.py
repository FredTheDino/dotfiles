#!/python3 
import os
from datetime import datetime
import json 

def suffix(d):
    match d: 
        case 1: return "st"
        case 2: return "nd"
        case 3: return "rd"
        case _: return "th"

button = int(os.getenv("button") is not None)
old_verbose = int(os.getenv("verbose"))
verbose = (button + old_verbose) % 2
if verbose:
    at = datetime.now().strftime("<i>%a</i> v%W <b>%H</b>:<b>%M</b> %Y-%m-%d")
else:
    at = datetime.now().strftime("<b>%H</b>:<b>%M</b> %d")
    [h, d] = at.split()
    at = h + " " + d + suffix(d)

print(json.dumps({ "full_text": at, "verbose": int(verbose) }))
