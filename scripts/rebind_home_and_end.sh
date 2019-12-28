#!/bin/bash

# Found keycodes with 'xev'
left=113
right=114

# Save original
xmodmap -pke > xmodmap.orig

xmodmap xmodmap.he_rebind