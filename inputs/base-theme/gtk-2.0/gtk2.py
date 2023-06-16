#!/usr/bin/env python3

## Handles parsing the gtk2 theme specified by the config file.
import sys
import re

## get theme path from args
theme_dir = sys.argv[1]
base_path = str(theme_dir + "gtk-2.0/gtkrc")
base_file_2 = open(base_path)



print()



