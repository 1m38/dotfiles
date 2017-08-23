#!/usr/bin/env python
"""print terminal 256 colors"""

from __future__ import print_function
import sys


def main():
    for i in range(256):
        print("\033[48;05;{cc}m {cc:3d} \033[0m\033[38;05;{cc}m {cc:3d} \033[0m".format(cc=i),
              end="")
        if (i + 1) % 8 == 0:
            print()

    return 0


if __name__ == "__main__":
    sys.exit(main())
