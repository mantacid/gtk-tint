#!/usr/bin/env python3

## made by Mantacid

## In order to allow the tinted themes to work properly, we need to update their metadata in the index.theme file.
## This task is trivial, and is handled by this file.

import sys
import re

## get index.theme file from theme path
theme_dir = sys.argv[1] ## needs trailing slash
suffix = sys.argv[2]    ## should be whatever is specified in the theme_init bash function in main.sh
theme_index = str(theme_dir + "index.theme")

## define regular expressions to match and replace in index.theme
match_list = ["(?<=Name=).+", "(?<=GtkTheme=).+", "(?<=MetacityTheme=).+"]

## open index.theme
index_FILE = open(theme_index, mode='r+')
index_str = index_FILE.read()
print(index_str)

## get theme name from file
y = re.search("(?<=Name=).+", index_str)
theme_name = y.group()
new_name = theme_name + suffix

## find and replace matches iteratively
x = index_str
for i in range(len(match_list)):
    x = re.sub(match_list[i], new_name, x)
else:
    index_str = x
index_FILE.close()

## open and overwrite the file with the new string
index_FILE = open(theme_index, "w")
index_FILE.write(index_str)
index_FILE.close()
