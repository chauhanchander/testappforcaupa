#!/usr/bin/env python
import re
data = """  ,100,"1,00,00,00",abcd,part 4,this "is , part" 5"""
PATTERN = re.compile(r'''((?:[^,"']|"[^"]*"|'[^']*')+)''')
listpat =  PATTERN.split(data)[1::2]

for i in listpat:
    if not i.strip():
        print("blank line")
    else:
        print(i)
