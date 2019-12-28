#!/usr/bin/python3
import sys, os, subprocess
from subprocess import CalledProcessError

if __name__ == '__main__':

  if len (sys.argv) < 2:
    sys.exit(1)

  cmd = 'echo -ne \"\\033]0;_TITLE_\\007\"'
  cmd = cmd.replace('_TITLE_', sys.argv[1])

  try:
    proc       = subprocess.Popen([cmd], stdout=subprocess.PIPE, shell=True)
    (out, err) = proc.communicate()
  except CalledProcessError as e:
    print("ERROR: " + e)
  else:
    print("OK: " + out.decode('utf-8').strip())
