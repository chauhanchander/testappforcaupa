#!/usr/bin/env python3
import unittest
import os
import subprocess


class TestNumber(unittest.TestCase):

    def test_case(self):
        input = "1 2 3 4 6 7 8"
        expected_output = '5'
        with os.popen("echo 1 2 3 4 6 | ./missingnumber.py") as o:
            output = o.read()
        output = output.strip() # Remove leading spaces and LFs
        self.assertEqual(output, expected_output)

    def test_case2(self):
        input = "5 7 8 9 10 11 12"
        expected_output = "6"
        with os.popen("echo 3 4 5 7 8 9| ./missingnumber.py") as o:
            output = o.read()
        output = output.strip() # Remove leading spaces and LFs
        self.assertEqual(output, expected_output)

if __name__ == '__main__':
    unittest.main()
