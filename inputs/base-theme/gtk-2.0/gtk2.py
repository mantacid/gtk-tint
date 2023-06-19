#!/usr/bin/env python3

## Handles parsing the gtk2 theme specified by the config file.
import sys
import re

## local names for args
conf_path = sys.argv[1]
target_theme = sys.argv[2]

## get data from main config
try:
    with open(conf_file_path, "rb") as f:
        conf_data = tomllib.load(f)
except:
    print("tomllib.TOMLDecodeError: Invalid TOML Format")
    
## get theme path from args
target_path = str(conf_path[theme_dir] + "/" + target_theme + "/gtk-2.0/gtkrc")

## open the file as text in read-write mode.
target_file = open(target_path)

## search the text for the relevant values
colors_raw = re.search("(?<=gtk-color-scheme =[\s\n]*")[.\n"]+", target_file)

## split raw string by newlines into dict
