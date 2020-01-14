#!/usr/bin/python3
import sys, os, math

if __name__ == '__main__':

  if len (sys.argv) < 2:
    sys.exit(1)

  _int = int(sys.argv[1])

  filling = 4

  if _int >= 2**16:
    filling = 8

  _hex = str(hex(_int)).replace('0x', '').zfill(filling)

  _hex_format = _hex[:4]
  _hex = _hex[4:]

  for i in range(len(_hex)//4):
    _hex_format += '_' + _hex[:4]
    _hex = _hex[4:]

  print(str(_int) + ' = 0x' + _hex_format.upper())

