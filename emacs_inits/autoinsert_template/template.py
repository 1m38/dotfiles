# coding: utf-8
"""docstring"""

from __future__ import print_function
from __future__ import unicode_literals
from __future__ import division
from __future__ import absolute_import
import os
import sys
import codecs
import re
import collections




if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("-a", "--argument", type=str, choices=[],
                        default="",
                        help="sample argument")

    args = parser.parse_args()
