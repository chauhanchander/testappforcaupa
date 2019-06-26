#!/usr/bin/env python3
import sys
import os
import string
 


def counteachword(filename):
    file = open(filename, "r+")
    wordcount = {}
    for word in file.read().split():
        if word not in wordcount:
            wordcount[word] = 1
        else:
            wordcount[word] += 1
    # print words count
    for key in wordcount.keys():
        print("%s %s " %(key, wordcount[key]))
    file.close()

filename = sys.argv[1]
if not os.path.exists(filename):
    raise Exception("Bad File")

counteachword(filename)

