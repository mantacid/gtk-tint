#!/usr/bin/env python3
import tomllib
import pprint
import sys

## define local names for args passed into this script
conf_file_path = sys.argv[1]

## Test the toml config format, load if valid. NOTE that python has trouble if you specify the home directory as ~, so use $HOME when calling this script.
try:
    with open(conf_file_path, "rb") as f:
        conf_data = tomllib.load(f)
except:
    print("tomllib.TOMLDecodeError: Invalid TOML Format")
    
## function to return a copy of a dict with certain keys excluded.
def exclude_key(d, key):
    blacklist = {key}
    return {x: d[x] for x in d if x not in blacklist}

## takes in a list of dictionaries, returns a dictionary of dictionaries, where each dictionary pair has a key of < the value corresponding to key K> and a value of <the same dictionary but with the entry for K removed> 
def list_to_dict(L, K):
    out_dict = dict({})
    for i in range(len(L)):
        ith_dict = L[i]
        identifier_key = str(ith_dict[K])
        trim_dict = exclude_key(ith_dict, K)
        out_dict[identifier_key] = trim_dict
    return out_dict

## turn a dictionary <d> into a list of tuples, some of which may contain dictionaries as the second element. prepend keys with the prefix <p> MIGHT BE ABLE TO REMOVE
def tuples_from_layer(d, p):
    tuple_list = []     ## set up empty list to populate
    prefix = str(p + "^")
    tuple_pre_list = list(d.items())
    for i in range(len(tuple_pre_list)):
        x=tuple_pre_list[i]
        y=list(x)
        y[0] = str(prefix + x[0])
        z = tuple(y)
        tuple_list.append(z)
    return tuple_list

## function to flatten a list of dictionaries
## takes the list inside the dictionary d that is paired to the key n, outputs a dict where all keys have p prepended to them
def flatten_list(d, n, p):
    prefix = str(p + "^")
    ## define local var for new list
    flat_dict = {}
    list_to_flatten = d[n]
    ## iterate through list
    for i in range(len(d[n])):
        new_name = str(prefix + n + "^" + str(i))
        flat_dict[new_name] = list_to_flatten[i]
    return flat_dict

## function to flatten nested dictionaries. call recursively
## takes in the main dict D, and the key for the subdict d, returns a flattened dictionary where all keys have p prepended to them
def flatten_dict(D, d, p):
    prefix = str(p + "^")
    ## define local empty dict
    flat_dict = {}
    dict_to_flatten = D[d]
    ## iterate through list
    for k in dict_to_flatten.keys():
        new_name = str(prefix + d + "^" + k)
        flat_dict[new_name] = dict_to_flatten[k]
    return flat_dict

## babe it's 3AM time for your...
def dict_flattening(d, p):  ## d is dict, p is running prefix
    ## in all seriousness though this funciton is infuriating to write.
    ## WIP
    prefix = str(p + "^")
    flat_dict = {}
    ## recurse through layers, calling flatten_list and flatten_dict where needed.
    for k in d.keys():
        if type(d[k]) is dict:
            pass
        elif type(d[k]) is list:
            pass
        else:
            new_key = str(prefix + k)
            flat_dict[new_key] = d[k]

## TESTS for flatten_dict and flatten_list functions, will be removed later
print(conf_data)
print("\n")
x = flatten_list(conf_data, "gtk2")
y = flatten_dict(x, "gtk2^0")
print(y)
z = flatten_dict(y,"gtk2^0^base_color")
print(z)
