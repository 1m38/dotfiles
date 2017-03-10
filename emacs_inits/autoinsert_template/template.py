# coding: utf-8
"""docstring"""

import os
import sys
import codecs
import re
import collections




def _main() -> int:
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("-a", "--argument", type=str, choices=[],
                        default="",
                        help="sample argument")

    args = parser.parse_args()
    ...

    return 0


if __name__ == "__main__":
    sys.exit(_main())
