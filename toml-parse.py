#!/usr/bin/env python3
import tomllib
import pprint
import sys
from cherrypicker import CherryPicker

## define local names for args passed into this script
conf_file_path = sys.argv[1]

## Test the toml config format, load if valid. NOTE that python has trouble if you specify the home directory as ~, so use $HOME when calling this script.
try:
    with open(conf_file_path, "rb") as f:
        conf_data = tomllib.load(f)
except:
    print("tomllib.TOMLDecodeError: Invalid TOML Format")

## babe it's 3 AM, time for your...
def dict_flattening(d):
    picker = CherryPicker(d)
    D = picker.flatten(delim='^').get()
    
    ## change the delimiter in the dictionary from whitespace to null
    dictStr = str(D)
    A = dictStr.replace(" ", "")
    
    ## get rid of the brackets
    B = A.replace("{", "")
    C = B.replace("}", "")
    
    ## replace colons with newlines so that when bash parses this script's output it can iterate over every OTHER value to get key-value pairs
    D = C.replace(":", "\n")
    
    ## add a newline after each pair (and replace ' with ") so that bash can parse it properly.
    N = D.replace(",", "\n")
    DICTSTR = N.replace("\'", "")
    
    return DICTSTR
    #print(picker.flatten(delim='^').get())



## TESTS will be removed later
#print(conf_data)
#print("\n")
configuration = open(conf_file_path, "rb")
X = tomllib.load(configuration)
x = dict_flattening(X)
print(x)
