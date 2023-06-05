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

## takes in a list of dictionaries, returns a dictionary of dictionaries, where each dictionary pair has a key of < the value corresponding to key K> and a value of <the same dictionary but with the entry for K removed> MIGHT BE ABLE TO REMOVE
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
## takes the list inside the dictionary d that is paired to the key n, outputs a dict
def flatten_list(d, n):
    #prefix = str(p + "^")
    ## define local var for new list
    flat_dict = {}
    list_to_flatten = d[n]
    ## iterate through list
    for i in range(len(d[n])):
        new_name = str(n + "^" + str(i))
        flat_dict[new_name] = list_to_flatten[i]
    return flat_dict

## function to flatten nested dictionaries. call recursively
## takes in the main dict D, and the key for the subdict d, returns a flattened dictionary where all keys have p prepended to them
def flatten_dict(D, d):
    #prefix = str(p + "^")
    ## define local empty dict
    flat_dict = {}
    dict_to_flatten = D[d]
    ## iterate through list
    for k in dict_to_flatten.keys():
        new_name = str(d + "^" + k)
        flat_dict[new_name] = dict_to_flatten[k]
    return flat_dict

## babe it's 3AM time for your...
def dict_flattening(d):  ## d is dict,
    ## in all seriousness though this funciton is infuriating to write.
    ## initialize the type list
    type_dict = {}
    ## set up new dict
    d_new = {}
    for k in d.keys():
        if type(d[k]) is list:  ## this part works, but then it stops. now we just have a dict in a dict instead of a list in a dict, but it doesnt do anything more with it.
            tmp_dict = flatten_list(d, k)
            for n in tmp_dict.keys():
                d_new[n] = tmp_dict[n]
            #trim_dict = exclude_key(d, k)
        elif type(d[k]) is dict:
            tmp_dict = flatten_dict(d, k)
            for n in tmp_dict.keys():
                d_new[n] = tmp_dict[n]
            #trim_dict = exclude_key(d, k)
        else:
            pass
    #d_new = trim_dict
    
    for k in d_new.keys():
        type_dict[k] = type(d_new[k])
    ## recursion logic
    if [dict not in type_dict.values()] and [list not in type_dict.values()]:
        return d_new
    else:
        dict_flattening(d_new)

## TESTS will be removed later
print(conf_data)
print("\n")
x = dict_flattening(conf_data)
print(x)
