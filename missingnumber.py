#!/usr/bin/env python3
import sys
import os
import string

def missing_number():
    numbers_input = input()
    num_list = list(map(int, numbers_input.split( )))
    return sum(range(num_list[0],num_list[-1]+1)) - sum(num_list)

print(missing_number())
