#!/usr/bin/env python
import re
word = 'core'
listofwords = "This is a Company of rEnowN"
def split(word):
    return [char for char in word]

print(word)
for i in  split(word):
    print(listofwords)
    listofwords = listofwords.replace(i.lower(), '')
    listofwords = listofwords.replace(i.upper(), '')
print (listofwords)
