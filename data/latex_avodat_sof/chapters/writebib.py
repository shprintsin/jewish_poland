import os
import glob

import glob
import re

os.listdir(".")
tex_files = glob.glob('**/*.tex', recursive=True)
variables = []
for file in tex_files:
    with open(file, 'r', encoding="utf8") as r:
        content = r.read()
    variables.extend(re.findall(r'@(\w+)', content))

yam="---\n"
for var in set(variables):
    yam+="\n"+var+"::"
with open("variables.yaml", "w",encoding="utf8") as w:
    w.write(yam)