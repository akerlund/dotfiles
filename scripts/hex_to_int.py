#!/usr/bin/python3
import sys, os

if __name__ == '__main__':

  filling = 8

  if len (sys.argv) < 2:
    sys.exit(1)

  _hex = sys.argv[1].replace('0x', '').zfill(filling)

  print('0x' + _hex + ' = ' + str(int(_hex, 16)))
