#!/usr/bin/env python3

import unittest
import wordcount


def test_wordcount():
    input_values = ['wordfile']
    output = []
 
    def mock_input(s):
        output.append(s)
        return input_values.pop(0)
    wordcount.input = mock_input
    wordcount.print = lambda s : output.append(s)
 
    wordcount.counteachword(input_values[0])
 
    assert output == [
	'Coupa 1 ', 
	'Software 1 ', 
	'is 1 ',
	'a 1 ', 
	'global 1 ', 
    ]
