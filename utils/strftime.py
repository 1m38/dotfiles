#!/usr/bin/env python3
# coding: utf-8
"""time(second) to string"""

import os
import sys
import codecs
import re
import collections
import math


def main():
    t = float(input())
    s = int(t % 60)
    m = int((t // 60) % 60)
    h = int(t // 60 // 60)

    r = "{:d}:{:02d}:{:02d}".format(h, m, s)
    print(r)


if __name__ == "__main__":
    sys.exit(main())
